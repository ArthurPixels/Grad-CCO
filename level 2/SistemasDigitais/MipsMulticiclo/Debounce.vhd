library ieee;
use ieee.std_logic_1164.all;
 
entity Debounce is
	port(
		clock: in std_logic;
		data: in std_logic;
		debouncedData: out std_logic
	);
end;
 
architecture comportamental of Debounce is
	signal OP1, OP2, OP3: std_logic; 
begin
	process(clock) is
	begin
		if rising_edge(clock) then
			OP1 <= data;
			OP2 <= OP1;
			OP3 <= OP2;
		end if;
	end process;
 
	debouncedData <= OP1 and OP2 and OP3;
end;