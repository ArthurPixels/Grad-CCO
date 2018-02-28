library ieee;
use ieee.std_logic_1164.all;
entity Adder4 is
port	( 	SW : IN STD_LOGIC_VECTOR(9 downto 0);
			LEDR : OUT STD_LOGIC_VECTOR(9 downto 0)
		);
end Adder4;

architecture Adder4_estru of Adder4 is
	signal C1, C2, C3: std_logic;

	component halfadder
	port	(	A: in std_logic;
				B: in std_logic;
				S: out std_logic;
				Co: out std_logic
			);
	end component;

	component fulladder
	port	(	A: in std_logic;
				B: in std_logic;
				C: in std_logic;
				S: out std_logic;
				Co: out std_logic
			);
	end component;


begin
	L0: halfadder port map (SW(0), SW(6), LEDR(0), C1);
	L1: fulladder port map (SW(1), SW(7), C1, LEDR(1), C2);
	L2: fulladder port map (SW(2), SW(8), C2, LEDR(2), C3);
	L3: fulladder port map (SW(3), SW(9), C3, LEDR(3), LEDR(4));
	
end Adder4_estru;