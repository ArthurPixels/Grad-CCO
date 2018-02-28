library ieee;
use ieee.std_logic_1164.all;

entity memoriaAssinc is 
	port(
		clock: 				in std_logic;
		lerMem, escMem: 	in std_logic;
		dados: 				in std_logic_vector	(31 downto 0);
		endereco: 			in std_logic_vector	(31 downto 0);
		dadoLido: 			out std_logic_vector	(31 downto 0)
	);
end entity;

architecture mem of memoriaAssinc is 
	component memoria IS
	PORT(
		address	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END component;

begin

RAM0: memoria port map (endereco(9 downto 2), clock, dados, escMem, dadoLido);

end architecture;