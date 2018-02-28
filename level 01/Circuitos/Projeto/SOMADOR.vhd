library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity SOMADOR is port (
	a: in std_logic_vector(9 downto 0);
	b: in std_logic_vector(9 downto 0);
	s: out std_logic_vector(9 downto 0)
	);
end entity;

architecture circuito of SOMADOR is
begin 
	s <=  a + b;
end circuito;