library ieee;
use ieee.std_logic_1164.all;

entity FSM_Position is port (	
		
		CHAVES: in std_logic_vector(1 downto 0);
		EN_TIME: in std_logic;
		SPEED: in std_logic_vector(2 downto 0);
		CLOCK_M: in std_logic;
		RST: in std_logic;
		UP_DOWN: out std_logic_vector(3 downto 0)
		);
end FSM_Position;

architecture behv of FSM_Position is
type STATES is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, SA, SB, SC, SD, SE, SF);
signal EA, PE: STATES;

begin
	P1: process(CLOCK_M, RST)
	begin
		if RST= '0' then
			EA <= S7;
		elsif CLOCK_M'event and CLOCK_M= '0' then
			EA <= PE;
		end if;
	end process;
	
	P2: process(EA)
	begin
		case EA is
			when S0 =>
				if CHAVES <= "01" then
				PE <= S1;
				end if;
			when S1 =>
				if CHAVES <= "01" then
				PE <= S2;
				elsif CHAVES <= "10" then
				PE <= S0;
				end if;
			when S2 => 
				if CHAVES <= "01" then
				PE <= S3;
				elsif CHAVES <= "10" then
				PE <= S1;
				end if;
			when S3 => 
				if CHAVES <= "01" then
				PE <= S4;
				elsif CHAVES <= "10" then
				PE <= S2;
				end if;
			when S4 => 
				if CHAVES <= "01" then
				PE <= S5;
				elsif CHAVES <= "10" then
				PE <= S3;
				end if;
			when S5 =>
				if CHAVES <= "01" then
				PE <= S6;
				elsif CHAVES <= "10" then
				PE <= S4;
				end if;
			when S6 =>
				if CHAVES <= "01" then
				PE <= S7;
				elsif CHAVES <= "10" then
				PE <= S5;
				end if;
			when S7 =>
				if CHAVES <= "01" then
				PE <= S8;
				elsif CHAVES <= "10" then
				PE <= S6;
				end if;
			when S8 =>
				if CHAVES <= "01" then
				PE <= S9;
				elsif CHAVES <= "10" then
				PE <= S7;
				end if;
			when S9 =>
				if CHAVES <= "01" then
				PE <= SA;
				elsif CHAVES <= "10" then
				PE <= S8;
				end if;
			when SA =>
				if CHAVES <= "01" then
				PE <= SB;
				elsif CHAVES <= "10" then
				PE <= S9;
				end if;
			when SB =>
				if CHAVES <= "01" then
				PE <= SC;
				elsif CHAVES <= "10" then
				PE <= SA;
				end if;
			when SC =>
				if CHAVES <= "01" then
				PE <= SD;
				elsif CHAVES <= "10" then
				PE <= SB;
				end if;
			when SD =>
				if CHAVES <= "01" then
				PE <= SE;
				elsif CHAVES <= "10" then
				PE <= SC;
				end if;
			when SE =>
				if CHAVES <= "01" then
				PE <= SF;
				elsif CHAVES <= "10" then
				PE <= SD;
				end if;
			when SF =>
				if CHAVES <= "10" then
				PE <= SE;
				end if;
		end case;
	end process;
end behv;
