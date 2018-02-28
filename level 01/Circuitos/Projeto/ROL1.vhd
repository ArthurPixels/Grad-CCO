library IEEE;
use IEEE.Std_Logic_1164.all;
entity ROL1 is
port (
		REG_IN: in std_logic_vector(31 downto 0);
		SET_ROL: in std_logic;
        EN_TIME: in std_logic;
        SPEED: in std_logic_vector (2 downto 0);
        CLOCK_M: in std_logic;
        RST: in std_logic;
        REG_OUT: out std_logic_vector(31 downto 0)
);
end entity;

architecture circuit of ROL1 is

signal sr: std_logic_vector(31 downto 0);
signal sr_aux: std_logic;

begin
	process(CLOCK_M,RST)
		begin
		if (RST = '0') then
			sr <= REG_IN;
            sr_aux <= REG_IN(31);
		elsif (CLOCK_M'event and CLOCK_M= '1') then
			if(SET_ROL = '1') then
				sr <= sr(30 downto 0) & sr_aux;
			end if;
			if ((EN_TIME = '1') and (SPEED(0) =  '1' OR SPEED(1) = '1' OR SPEED(2) = '1')) then
				sr_aux <= REG_IN(31);
				sr(31 downto 1) <= REG_IN(30 downto 0);
				sr(0) <= sr_aux;
			end if;
		end if;
	end process;
	REG_OUT <= sr;
end;
