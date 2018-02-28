library IEEE;
use IEEE.Std_Logic_1164.all;

entity fulladder is
port	(	A: in std_logic;
			B: in std_logic;
			C: in std_logic;
			S: out std_logic;
			Co: out std_logic
		);
end fulladder;

architecture circuito_logico of fulladder is
begin
S	<= A xor B xor C;
Co	<= (A and B) or (A and C) or (B and C);
end circuito_logico;