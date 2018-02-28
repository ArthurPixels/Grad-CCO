library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity CONTA_DES is
port (
		  EN_TIME: in std_logic;
        CLK1: in std_logic;
        RST: in std_logic;
        CNT_D: out std_logic_vector(9 downto 0)


		--EN_TIME, CLK1, RST: in std_logic;
		--CNT_D : out std_logic_vector(9 downto 0)
	);
end entity;

architecture control of CONTA_DES is
signal registraCNT_D: std_logic_vector(9 downto 0);

begin
P1: process(CLK1,RST,EN_TIME)
	begin
		if RST = '1' then
			registraCNT_D <= "0001100011";

		elsif (CLK1'event and CLK1= '1' and EN_TIME = '1') then
			registraCNT_D <= registraCNT_D - '1';
			 
		end if;
		
	end process;
		CNT_D <= registraCNT_D;
end control;