library ieee;
use ieee.std_logic_1164.all;

entity FSM_Speed is port (	
        ACC: in std_logic;
        BRK: in std_logic;
        EN_TIME: in std_logic;
        CLK: in std_logic;
        RST: in std_logic;
        SPEED: out std_logic_vector(2 downto 0)
		);
end entity;

architecture behv of FSM_Speed is
type STATES is (S0, S1, S2, S3, S4, S5);
signal EA, PE: STATES;

begin
	P1: process(CLK, RST)
	begin
		if RST= '0' then
			EA <= S0;
		elsif CLK'event and CLK= '0' and EN_TIME = '1' then
			EA <= PE;
		end if;
	end process;
	
	P2: process(EA)
	begin
		case EA is
			when S0 =>
                if (ACC = '1' and BRK = '0') then
                    PE <= S1;
                end if;
                SPEED <= "000";
         when S1 =>
                if (ACC = '1' and BRK = '0') then
                    PE <= S2;
                elsif (ACC = '0' and BRK = '1') then
                    PE <= S0;
                end if;
                SPEED <= "001";
            when S2 =>
                if (ACC = '1' and BRK = '0') then
                    PE <= S3;
                elsif (ACC = '0' and BRK = '1') then
                    PE <= S1;
                end if;
                SPEED <= "010";
            when S3 =>
                if (ACC = '1' and BRK = '0') then
                    PE <= S4;
                elsif (ACC = '0' and BRK = '1') then
                    PE <= S2;
                end if;
                SPEED <= "011";
            when S4 =>
                if (ACC = '1' and BRK = '0') then
                    PE <= S5;
                elsif (ACC = '0' and BRK = '1') then
                    PE <= S3;
                end if;
                SPEED <= "100";
            when S5 =>
                if (ACC = '0' and BRK = '1') then
                    PE <= S4;
                end if;
                SPEED <= "101";
		end case;
	end process;
end behv;
