library ieee;
use ieee.std_logic_1164.all;
entity Subtraction is
port	( 	SW : IN STD_LOGIC_VECTOR(9 downto 0);
			LEDR : OUT STD_LOGIC_VECTOR(9 downto 0);
			HEX0: OUT STD_LOGIC_VECTOR(6 downto 0)
		);
end Subtraction;

architecture Subtraction_estru of Subtraction is
	signal C, D: std_logic_vector(4 downto 0);
	signal F: std_logic_vector (3 downto 0);

	component fulladder
	port	(	A: in std_logic_vector(4 downto 0);
				B: in std_logic_vector(4 downto 0);
				S: out std_logic_vector(4 downto 0)
			);
	end component;
	
	component MUX4x1 --TROLL
	port	(	w: in std_logic_vector(4 downto 1);
				x: in std_logic_vector(4 downto 1);
			
				s: in std_logic;
				m: out std_logic_vector(3 downto 0)
			);
	end component;

	component Decod7seg
	port (C: in std_logic_vector(3 downto 0);
			F: out std_logic_vector(6 downto 0)
	);
	end component;

begin
	L0: fulladder port map (SW(4 downto 0), SW(9 downto 5), C);
	F1: fulladder port map (SW(9 downto 5), SW(4 downto 0), D);
	L3: MUX4x1 port map (C(3 downto 0), D(3 downto 0), C(4), F);
	L4: Decod7seg port map (F, HEX0);
	LEDR(9) <= C(4);
	
end Subtraction_estru;