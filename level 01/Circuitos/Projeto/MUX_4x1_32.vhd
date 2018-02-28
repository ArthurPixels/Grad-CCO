library IEEE;
use IEEE.Std_Logic_1164.all;

entity MUX_4x1_32 is
port	(	a: in std_logic_vector (31 downto 0);
			b: in std_logic_vector (31 downto 0);
			c: in std_logic_vector (31 downto 0);
			d: in std_logic_vector (31 downto 0);
			
			s: in std_logic_vector (1 downto 0);
			x: out std_logic_vector (31 downto 0)
		);
end entity;

architecture circuito_logico of MUX_4x1_32 is
begin
x <= 	a when s = "00" else
		b when s = "01" else
		c when s = "10" else
		d ; -- "11"
end circuito_logico;