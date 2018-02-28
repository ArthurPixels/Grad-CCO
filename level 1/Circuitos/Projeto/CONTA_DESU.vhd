library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity CONTA_DESU is
port (
		  REG_ROM31: in std_logic;
        EN_TIME: in std_logic;
        CLK_M: in std_logic;
        RST: in std_logic;
        CNT_B: out std_logic_vector(4 downto 0)

		--EN_TIME, CLK_M, RST: in std_logic;
		--REG_ROM31: in std_logic;
		--CNT_B : out std_logic_vector(4 downto 0)
	);
end entity;

architecture control of CONTA_DESU is
signal registraCNT_B: std_logic_vector(4 downto 0);

begin
	
	P1: process(RST,CLK_M,EN_TIME) 
	begin

		if RST = '1' then
			registraCNT_B <= "00101";
		elsif (CLK_M'event and CLK_M= '1' and EN_TIME = '1') then
			 registraCNT_B <= registraCNT_B - '1';
		end if;
	end process;
		CNT_B <= registraCNT_B;
end control;