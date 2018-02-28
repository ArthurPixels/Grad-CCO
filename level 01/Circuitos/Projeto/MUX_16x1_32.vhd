library IEEE;
use IEEE.Std_Logic_1164.all;

entity MUX_16x1_32 is
port	(	a: in std_logic_vector (31 downto 0);
			b: in std_logic_vector (31 downto 0);
			c: in std_logic_vector (31 downto 0);
			d: in std_logic_vector (31 downto 0);
			
			e: in std_logic_vector (31 downto 0);
			f: in std_logic_vector (31 downto 0);
			g: in std_logic_vector (31 downto 0);
			h: in std_logic_vector (31 downto 0);
			
			i: in std_logic_vector (31 downto 0);
			j: in std_logic_vector (31 downto 0);
			k: in std_logic_vector (31 downto 0);
			l: in std_logic_vector (31 downto 0);
			
			m: in std_logic_vector (31 downto 0);
			n: in std_logic_vector (31 downto 0);
			o: in std_logic_vector (31 downto 0);
			p: in std_logic_vector (31 downto 0);
			
			s: in std_logic_vector (3 downto 0);
			x: out std_logic_vector (31 downto 0)
		);
end MUX_16x1_32;

architecture circuito_logico of MUX_16x1_32 is
begin
x <= 	a when s = "0000" else
		b when s = "0001" else
		c when s = "0010" else
		d when s = "0011" else
		
		e when s = "0100" else
		f when s = "0101" else
		g when s = "0110" else
		h when s = "0111" else
		
		i when s = "1000" else
		j when s = "1001" else
		k when s = "1010" else
		l when s = "1011" else
		
		m when s = "1100" else
		n when s = "1101" else
		o when s = "1110" else
		p ; -- "1111"
end circuito_logico;