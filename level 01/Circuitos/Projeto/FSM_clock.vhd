library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity FSM_clock is port (	
		
		CLK  : in std_logic;
		CLK1 : out std_logic;
		CLK2 : out std_logic;
		CLK3 : out std_logic;
		CLK4 : out std_logic;
		CLK5 : out std_logic
		);
end entity;

architecture behv of FSM_clock is
type STATES is (E0, E1);
signal EA1, EA2, EA3, EA4, EA5, PE1, PE2, PE3, PE4, PE5: STATES;
signal contador1,contador2,contador3,contador4,contador5: std_logic_vector(27 downto 0);

begin
	P1: process(CLK)
	begin
		if CLK'event and CLK= '1' then
			contador1 <= contador1 + '1';
			contador2 <= contador2 + '1';
			contador3 <= contador3 + '1';
			contador4 <= contador4 + '1';
			contador5 <= contador5 + '1';
		end if;
		if contador1 >= x"17D783F" then
			contador1 <= x"0000000";
			EA1 <= PE1;
		end if;
        if contador2 >= x"0BEBC1F" then
			contador2 <= x"0000000";
			EA2 <= PE2;
		end if;
        if contador3 >= x"07F2815" then
			contador3 <= x"0000000";
			EA3 <= PE3;
		end if;
        if contador4 >= x"05F5E0F" then
			contador4 <= x"0000000";
			EA4 <= PE4;
		end if;
        if contador5 >= x"04C4B3F" then
			contador5 <= x"0000000";
			EA5 <= PE5;
		end if;
	end process;
	
	P2: process(EA1)
    begin
        case EA1 is
            when E0 =>
                CLK1 <= '0';
					 PE1 <= E1;
            when E1 =>
                CLK1 <= '1';
					 PE1 <= E0;
        end case;
    end process;

    P3: process(EA2)
    begin
        case EA2 is
            when E0 =>
                CLK2 <= '0';
					 PE2 <= E1;
            when E1 =>
                CLK2 <= '1';
					 PE2 <= E0;
        end case;
    end process;

    P4: process(EA3)
    begin
        case EA3 is
            when E0 =>
                CLK3 <= '0';
					 PE3 <= E1;
            when E1 =>
                CLK3 <= '1';
					 PE3 <= E0;
        end case;
    end process;

    P5: process(EA4)
    begin
        case EA4 is
            when E0 =>
                CLK4 <= '0';
					 PE4 <= E1;
            when E1 =>
                CLK4 <= '1';
					 PE4 <= E0;
        end case;
    end process;

    P6: process(EA5)
    begin
        case EA5 is
            when E0 =>
                CLK5 <= '0';
					 PE5 <= E1;
            when E1 =>
                CLK5 <= '1';
					 PE5 <= E0;
        end case;
    end process;
end architecture;
