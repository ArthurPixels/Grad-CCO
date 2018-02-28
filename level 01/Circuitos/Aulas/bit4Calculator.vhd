library ieee;
use ieee.std_logic_1164.all;
entity bit4Calculator is
port	( 	SW : IN STD_LOGIC_VECTOR(9 downto 0);
			LEDR : OUT STD_LOGIC_VECTOR(9 downto 0);
			HEX0: OUT STD_LOGIC_VECTOR(6 downto 0)
		);
end bit4Calculator;

architecture bit4Calculator_estru of bit4Calculator is
	signal F1, F2, F3, F4, F5: std_logic_vector (3 downto 0);
	
	component MUX4x1
	port	(	w: in std_logic_vector(3 downto 0);
				x: in std_logic_vector(3 downto 0);
				y: in std_logic_vector(3 downto 0);
				z: in std_logic_vector(3 downto 0);
				s: in std_logic_vector(1 downto 0);
				m: out std_logic_vector(3 downto 0)
			);
	end component;

	component C1
	port (A: in std_logic_vector (3 downto 0);
			B: in std_logic_vector (3 downto 0);
			F: out std_logic_vector (3 downto 0)
	);
	end component;
	
	component C2
	port (A: in std_logic_vector (3 downto 0);
			B: in std_logic_vector (3 downto 0);
			F: out std_logic_vector (3 downto 0)
	);
	end component;

	component C3
	port (A: in std_logic_vector (3 downto 0);
			B: in std_logic_vector (3 downto 0);
			F: out std_logic_vector (3 downto 0)
	);
	end component;
	
	component C4
	port (A: in std_logic_vector (3 downto 0);
			F: out std_logic_vector (3 downto 0)
	);
	end component;
	
	component Decod7seg
	port (C: in std_logic_vector(3 downto 0);
			F: out std_logic_vector(6 downto 0)
	);
	end component;

begin
	L0: C1 port map (SW(3 downto 0), SW(7 downto 4), F1);
	L1: C2 port map (SW(3 downto 0), SW(7 downto 4), F2);
	L2: C3 port map (SW(3 downto 0), SW(7 downto 4), F3);
	L3: C4 port map (SW(3 downto 0), F4);
	L4: MUX4x1 port map (F1, F2, F3, F4, SW(9 downto 8), F5);
	L5: Decod7seg port map (F5, HEX0);
	LEDR <= "000000" & F5;
end bit4Calculator_estru;
