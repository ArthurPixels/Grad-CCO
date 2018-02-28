library IEEE;
use IEEE.Std_Logic_1164.all;

entity halfadder is
port (                                               -- A -> SW(0)
      SW  : in std_logic_vector( 9 downto 0);          -- B -> SW(1)
	   LEDR: out std_logic_vector( 9 downto 0)        -- sum -> LEDR(0)
		);                                             -- carry -> LEDR(1)
end halfadder;

architecture ha_stru of halfadder is
begin
	LEDR(0) <= SW(0) xor SW(1);      -- sum <=  A xor B
	LEDR(1) <= SW(0) and SW(1);      -- carry <= A and B
end ha_stru;