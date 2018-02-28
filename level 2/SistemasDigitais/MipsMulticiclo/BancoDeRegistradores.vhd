library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoRegistradores is 
   generic(
      larguraDeDados: natural := 32;
      bitsRegSerLido: natural := 5
   );
   port(
      clock, reset: in std_logic;
      EscReg: in std_logic;
      RegSerLido1, RegSerLido2, RegSerEscrito: in std_logic_vector(bitsRegSerLido-1 downto 0);
      DadoEscrita: in std_logic_vector(larguraDeDados-1 downto 0);      
      DadoLido1, DadoLido2: out std_logic_vector(larguraDeDados-1 downto 0)
   );
end entity;

architecture comportamental of bancoRegistradores is 
type estado is array(0 to (2**bitsRegSerLido)-1) of std_logic_vector(larguraDeDados-1 downto 0);
signal estadoAtual, proximoEstado: estado;

begin

	-- state register
	StateRegister: process(clock, reset)
	begin
		if reset = '1' then
			for i in estadoAtual'range loop
				estadoAtual(i) <= (others => '0');
			end loop;
		elsif rising_edge(clock) then
			estadoAtual <= proximoEstado;
		end if;
	end process;

	-- next state logic
	NextStateLogic: process(estadoAtual, EscReg, RegSerEscrito, DadoEscrita) is
	begin
		proximoEstado <= estadoAtual;
		for i in estadoAtual'range loop
			if EscReg = '1' then
				if i = to_integer(unsigned(RegSerEscrito)) then
					proximoEstado(i) <= DadoEscrita; 
				end if;
			end if;
		end loop;
	end process;

	-- output logic
	DadoLido1 <= estadoAtual(to_integer(unsigned(RegSerLido1)));
	DadoLido2 <= estadoAtual(to_integer(unsigned(RegSerlido2)));

end architecture;