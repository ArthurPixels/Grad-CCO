library IEEE;
use IEEE.Std_Logic_1164.all;
entity C3 is
port (A: in std_logic;
B: in std_logic;
C: in std_logic;
F: out std_logic
);
end C3;
  
architecture c3_estr of C3 is
begin
F <= (A or B) and (not C);
end c3_estr;