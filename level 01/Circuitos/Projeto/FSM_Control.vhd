library IEEE;
use IEEE.Std_Logic_1164.all;

entity FSM_Control is
port (
		RESET,ENTER,END_TIME,END_BONUS,TARGET,CLOCK: in std_logic;
		STATES: out std_logic_vector(4 downto 0);
		SEL_DISP: out std_logic_vector(1 downto 0);
		SEL_LED,SET_ROL,EN_TIME,RST: out std_logic
);
end FSM_Control;

architecture control of FSM_Control is
signal PE,EA: std_logic_vector(4 downto 0);
begin
P1: process(CLOCK, RESET)
	begin
		if RESET = '0' then
			EA <= "00000";
			STATES <= "00000";
		elsif CLOCK'event and CLOCK= '0' then
			EA <= PE;
			STATES <= PE;
		end if;
	end process;
	
	P2: process(EA)
	begin
		case EA is
			when "00000" =>
				if ENTER = '0' then
					PE <= "00001";
				else
					PE <= "00000";
				end if;
				SEL_LED <= '1';
				SEL_DISP <= "10";
				SET_ROL <= '0';
				EN_TIME <= '0';
				RST <= '1';
				
			when "00001" =>
				if ENTER = '0' then
					PE <= "00010";
				else
					PE <= "00001";
				end if;
				SEL_LED <= '1';
				SEL_DISP <= "01";
				SET_ROL <= '1';
				EN_TIME <= '0';
				RST <= '0';
				
			when "00010" =>
				if TARGET = '1' or End_time = '1' or End_Bonus = '1' then
					PE <= "00011";
				else
					PE <= "00010";
				end if;
				SEL_LED <= '0';
				SEL_DISP <= "00";
				SET_ROL <= '0';
				EN_TIME <= '1';
				RST <= '0';
				
			when "00011" =>
				if ENTER = '0' then
					PE <= "00000";
				else
					PE <= "00011";
				end if;
				SEL_LED <= '1';
				SEL_DISP <= "11";
				SET_ROL <= '0';
				EN_TIME <= '0';
				RST <= '0';
			when others =>
				PE <= "00000";
		end case;
	end process;
end control;