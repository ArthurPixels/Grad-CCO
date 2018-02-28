library ieee;
use IEEE.std_logic_1164.all;

entity COMPARADOR_5 is port (
	a: in std_logic_vector(4 downto 0);
	b: in std_logic_vector(4 downto 0);
	s: out std_logic
	);
end entity;

architecture circuito of COMPARADOR_5 is
begin 
	s <= ((a(4) xnor b(4)) and
		  (a(3) xnor b(3)) and (a(2) xnor b(2)) and
		  (a(1) xnor b(1)) and (a(0) xnor b(0)));	  
end;