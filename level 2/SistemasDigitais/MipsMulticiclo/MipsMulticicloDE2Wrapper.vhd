library ieee;
use ieee.std_logic_1164.all;

entity MipsMulticicloDE2Wrapper is
	port(
		CLOCK_50: in std_logic;
		KEY: in std_logic_vector(3 downto 0); -- key(0):clock, key(1):reset
		SW: in std_logic_vector(7 downto 0);
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0);
		LEDR: out std_logic_vector(15 downto 0);
		LEDG: out std_logic_vector(3 downto 0)
	);
end;

architecture estrutural of MipsMulticicloDE2Wrapper is
	component MipsMulticiclo is
		port(
			clock, reset: in std_logic;
			EnderecoInstrucao, EnderecoDados,
			ValorInstrucao, ValorDados,
			ValorULA: out std_logic_vector(15 downto 0);
			SinaisControle: out std_logic_vector(15 downto 0);
			EstadoControle: out std_logic_vector(3 downto 0) -- pode ser necessario alterar a largura
		);
	end component;
	
	component Decoder7Segments is
		port(
			input: in std_logic_vector(3 downto 0);
			display: out std_logic_vector(6 downto 0)
		);
	end component;
	
	component Debounce is
		port(
			clock: in std_logic;
			data: in std_logic;
			debouncedData: out std_logic
		);
	end component;
	
	signal EnderecoInstrucao, EnderecoDados,
			ValorInstrucao, ValorDados, ValorULA,
			SinaisControle,
			EstadoControle16bits : std_logic_vector(15 downto 0);
	signal EstadoControle: std_logic_vector(3 downto 0); -- pode ser necessario alterar a largura
	signal debClock, debReset: std_logic;
	
	constant displayS: std_logic_vector(3 downto 0) := "0101";
begin
	DebClk: Debounce port map(CLOCK_50, not(KEY(3)), debClock);

	DebRst: Debounce port map(CLOCK_50, not(KEY(1)), debReset);

	MIPS: MipsMulticiclo port map(
		debClock, debReset,
		EnderecoInstrucao, EnderecoDados,
		ValorInstrucao, ValorDados,ValorULA, 
		SinaisControle, EstadoControle);
		
	H0: Decoder7Segments port map(EnderecoInstrucao(3 downto 0), HEX0);	
	H1: Decoder7Segments port map(EnderecoInstrucao(7 downto 4), HEX1);	
	H2: Decoder7Segments port map(EnderecoDados(3 downto 0), HEX2);	
	H3: Decoder7Segments port map(EnderecoDados(7 downto 4), HEX3);	

	H4: Decoder7Segments port map(ValorDados(3 downto 0), HEX4);	
	H5: Decoder7Segments port map(ValorDados(7 downto 4), HEX5);	

	H6: Decoder7Segments port map(EstadoControle, HEX6);	
	H7: Decoder7Segments port map(displayS, HEX7);
	
	LEDG <= KEY;
	
	LEDR <= 	EnderecoInstrucao 	when SW(0)='1' else
				EnderecoDados 			when SW(1)='1' else
				ValorInstrucao 		when SW(2)='1' else
				ValorDados 				when SW(3)='1' else
				ValorULA 				when SW(4)='1' else
				SinaisControle 		when SW(5)='1' else
				EstadoControle16bits ;
				
	EstadoControle16bits  <= "000000000000" & EstadoControle;
end;

	