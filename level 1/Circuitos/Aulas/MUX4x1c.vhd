library IEEE;
use IEEE.Std_Logic_1164.all;

entity MUX4x1c is
port	(	w: in std_logic;
			x: in std_logic;
			y: in std_logic;
			z: in std_logic;
			s: in std_logic_vector (1 downto 0);
			m: out std_logic 
		);
end MUX4x1c;

architecture circuito_logico of MUX4x1c is
begin
m <= 	w when s = "00" else
		x when s = "01" else
		y when s = "10" else
		z; -- "11"
end circuito_logico;