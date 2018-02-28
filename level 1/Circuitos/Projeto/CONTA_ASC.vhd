library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity CONTA_ASC is
port (
		  EN_TIME: in std_logic;
        SPEED: in std_logic_vector(2 downto 0);
        CLK_M: in std_logic;
        RST: in std_logic;
        CNT_U: out std_logic_vector(9 downto 0)
);
end entity;

architecture control of CONTA_ASC is
signal  registraCNT_U: std_logic_vector(9 downto 0);
begin

	P1: process (RST,CLK_M) begin
		if RST = '1' then
			registraCNT_U <= "0000000000";
		elsif CLK_M'event and CLK_M = '1' then
			if (EN_TIME = '1') and (SPEED(0) =  '1' OR SPEED(1) = '1' OR SPEED(2) = '1') then
				registraCNT_U <= registraCNT_U + '1';
			 end if;
		end if;
	end process;
	CNT_U <= registraCNT_U;
end control;