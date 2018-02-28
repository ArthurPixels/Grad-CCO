library ieee;
use ieee.std_logic_1164.all;
entity MUXcomportamental is
port	( 	SW : IN STD_LOGIC_VECTOR(9 downto 0);
			LEDR : OUT STD_LOGIC_VECTOR(9 downto 0)
		);
end MUXcomportamental;

architecture MUXcomportamental_estru of MUXcomportamental is
	signal F1, F2, F3: std_logic;

	component MUX4x1c
	port	(	w: in std_logic;
				x: in std_logic;
				y: in std_logic;
				z: in std_logic;
				s: in std_logic_vector (1 downto 0);
				m: out std_logic
			);
	end component;

	component C1
	port (A : in std_logic;
			B : in std_logic;
			C : in std_logic;
			F : out std_logic);
	end component;
	
	component C2
	port (A : in std_logic;
			B : in std_logic;
			F : out std_logic);
	end component;

	component C3
	port (A : in std_logic;
			B : in std_logic;
			C : in std_logic;
			F : out std_logic
			);
	end component;


begin
	L0: C1 port map (SW(0), SW(1), SW(2), F1);
	L1: C2 port map (SW(1), SW(2), F2);
	L2: C3 port map (SW(2), SW(1), SW(0), F3);
	L3: MUX4x1c port map (F1, F2, F3, SW(6), SW(9 downto 8), LEDR(0));
end MUXcomportamental_estru;

