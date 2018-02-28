library IEEE;
use IEEE.Std_Logic_1164.all;

entity MUX4x1e is
port	(	w: in std_logic;
			x: in std_logic;
			y: in std_logic;
			z: in std_logic;
			s0:in std_logic;
			s1:in std_logic;
			m: out std_logic
		);
end MUX4x1e;

architecture circuito_logico of MUX4x1e is
begin
m <= (((not (s1)) and (not (s0))and w) or
		((not s1) and s0 and x) or
		(s1 and (not s0) and y) or
		(s1 and s0 and z));
end circuito_logico;