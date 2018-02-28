library IEEE;
use ieee.std_logic_1164.all;

entity registrador is
   generic(larguraDeDados: natural := 32;
				iniciaPC: std_logic_vector(31 downto 0) := "111111111111111111111111111100");
   port(
      clock, reset: in std_logic;
      en: in std_logic;
      d: in std_logic_vector(larguraDeDados-1 downto 0);
      q: out std_logic_vector(larguraDeDados-1 downto 0)
   );
end entity;

architecture comportamental of registrador is
signal estadoAtual,proximoEstado: std_logic_vector(larguraDeDados-1 downto 0);

begin
	-- Memory/state element
	StateRegister: process(clock, reset)
	begin
		if reset = '1' then
			estadoAtual <= (others => '0');
		elsif rising_edge(clock) then
			estadoAtual <= proximoEstado;
		end if;
	end process;

	-- next state logic
	proximoEstado <= d when en='1' else estadoAtual;
	
	-- output logic
	q <= estadoAtual;

end architecture;