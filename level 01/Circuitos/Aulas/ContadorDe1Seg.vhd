library ieee;
use ieee.std_logic_1164.all;

entity ContadorDe1Seg is
port(
	KEY : IN std_logic_vector(3 downto 0);
	HEX0: out std_logic_vector(6 downto 0);
	LEDR : out std_logic_vector(9 downto 0);
	CLOCK_50: in std_logic
	);
end ContadorDe1Seg;

architecture bhv of ContadorDe1Seg is
signal QQ, q: std_logic_vector(3 downto 0);
signal F: std_logic_vector (3 downto 0);
	
component Reg4en
port (
	CLK, RST: in std_logic;
	D: in std_logic_vector(3 downto 0);
	Q: out std_logic_vector(3 downto 0)
);
end component;
component decod7seg
port (
C: in std_logic_vector(3 downto 0);
F: out std_logic_vector(6 downto 0)
);
end component;

component FSM
port (contagem: out std_logic_vector(3 downto 0);
		clock: in std_logic;
		reset: in std_logic
		);
end component;

begin
	LEDR <= "000000" & F;
	L0: FSM port map (F ,CLOCK_50 ,key(0));
	L1: Reg4en port map (KEY(1), KEY(0), QQ(3 downto 0), q(3 downto 0));
	L2: decod7seg port map (F(3 downto 0), HEX0);

end bhv;