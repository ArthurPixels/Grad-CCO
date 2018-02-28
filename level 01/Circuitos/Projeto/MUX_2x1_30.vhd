library IEEE;
use IEEE.Std_Logic_1164.all;

entity MUX_2x1_30 is
port	(	a: in std_logic_vector (29 downto 0);
			b: in std_logic_vector (29 downto 0);
			
			s: in std_logic;
			x: out std_logic_vector (29 downto 0)
		);
end MUX_2x1_30;

architecture circuito_logico of MUX_2x1_30 is
begin
x <= 	a when s = '0' else
		b ; -- "1"
end circuito_logico;