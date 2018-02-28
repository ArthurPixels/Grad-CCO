library IEEE;
use IEEE.Std_Logic_1164.all;

entity MUX_8x1 is
port	(	a: in std_logic;
			b: in std_logic;
			c: in std_logic;
			d: in std_logic;
			
			e: in std_logic;
			f: in std_logic;
			g: in std_logic;
			h: in std_logic;
			
			s: in std_logic_vector (2 downto 0);
			x: out std_logic 
		);
end entity;

architecture circuito_logico of MUX_8x1 is
begin
x <= 	a when s = "000" else
		b when s = "001" else
		c when s = "010" else
		d when s = "011" else
		
		e when s = "100" else
		f when s = "101" else
		g when s = "110" else
		h ; -- "111"
end circuito_logico;