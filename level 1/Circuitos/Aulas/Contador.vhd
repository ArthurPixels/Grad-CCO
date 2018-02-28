library ieee;
use ieee.std_logic_1164.all;
entity Contador is
port (
KEY : IN std_logic_vector(3 downto 0);
HEX0: out std_logic_vector(6 downto 0);
LEDR : out std_logic_vector(9 downto 0)
);
end Contador;

architecture topo_estru of Contador is
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


begin
QQ(3) <= '0';
QQ(2) <= (not(q(3)) and not(q(2)) and q(1) and q(0));
QQ(1) <= (not(q(3)) and not(q(2))) and (q(1) xor q(0));
QQ(0) <= (not(q(3)) and q(2) and not(q(1))) or (not(q(3)) and not(q(2))
			 and q(1) and not(q(0)));
F <= q;
LEDR <= "000000" & F;

L0: Reg4en port map (KEY(1), KEY(0), QQ(3 downto 0), q(3 downto 0));

L2: decod7seg port map (F(3 downto 0), HEX0);
end topo_estru;