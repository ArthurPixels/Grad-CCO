library IEEE;
use ieee.std_logic_1164.all;

entity blocoOperativo is 
   port(
      clock, reset: in std_logic;
      PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA: in std_logic;
      ULAFonteB, ULAOp, FontePC: in std_logic_vector(1 downto 0);
      opcode: out std_logic_vector(5 downto 0);
		EnderecoInstrucao, EnderecoDados,
		ValorInstrucao, ValorDados,
		ValorULA: out std_logic_vector(15 downto 0)
   );
end entity;

architecture estrutural of blocoOperativo is
  
component ula is
	generic(width: positive := 14);
	port(
		a, b: in std_logic_vector(width-1 downto 0);
		op: in std_logic_vector(2 downto 0);  --000:AND , 001:OR , 010:ADD, 110:SUB, 111:SLT
		zero: out std_logic;
		res: out std_logic_vector(width-1 downto 0)
	);
end component;

component operacaoULA is
	port(
		ULAOp: in std_logic_vector(1 downto 0);
		Funct: in std_logic_vector(5 downto 0);
		op: out std_logic_vector(2 downto 0)
	);
end component;


component memoriaAssinc is
	port(
		clock: 				in std_logic;
		lerMem, escMem: 	in std_logic;
		dados: 				in std_logic_vector	(31 downto 0);
		endereco: 			in std_logic_vector	(31 downto 0);
		dadoLido: 			out std_logic_vector	(31 downto 0)
	);
end component;


component deslocadorEsquerda is
	generic(largura: natural := 8);
   port(
      entrada: in std_logic_vector(largura-1 downto 0);
      saida: out std_logic_vector(largura-1 downto 0)
   );
end component;


component mux4x1nbits is
	generic(width: integer := 4);
	port(
		inpt0, inpt1, inpt2, inpt3: in std_logic_vector(width-1 downto 0);
		sel: in std_logic_vector(1 downto 0);
		outp: out std_logic_vector(width-1 downto 0)
	);
end component;


component mux2x1nbits is
   	generic(width: integer := 4);
	port(
		inpt0: in std_logic_vector(width-1 downto 0);
		inpt1: in std_logic_vector(width-1 downto 0);
		sel: in std_logic;
		outp: out std_logic_vector(width-1 downto 0)
	);
end component;


component bancoRegistradores is
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
end component;

component registrador is
   generic(larguraDeDados: natural := 32;
				iniciaPC: std_logic_vector(31 downto 0) := "11111111111111111111111111111100");
   port(
      clock, reset: in std_logic;
      en: in std_logic;
      d: in std_logic_vector(larguraDeDados-1 downto 0);
      q: out std_logic_vector(larguraDeDados-1 downto 0)
   );
end component;

component signalExtend is
  generic(	finalWidth:  integer := 12;
				actualWidth: integer := 6);
	port(
		input:  in  std_logic_vector(actualWidth-1 downto 0);
		output: out std_logic_vector(finalWidth-1 downto 0)
	);
end component;

signal zeroULA, enablePC: std_logic;

signal entradaPC, saidaRegPC, saidaMem, saidaMuxPC, saidaRegULA, saidaRegInstr: std_logic_vector(31 downto 0);
signal regLido1, regLido2, saidaRegDadosMem, dadoEscReg, dadoEscMem, saidaRegA, saidaRegB: std_logic_vector(31 downto 0);
signal saidaMuxAULA, saidaMuxBULA, saidaExtensaoSinal, saidaExtensaoSinalDesl, saidaULA: std_logic_vector(31 downto 0);
--signal saidaRegULA : std_logic_vector(31 downto 0);

signal saidaMuxRegSerEscrito: std_logic_vector(4 downto 0);
signal ctrlULA : std_logic_vector(2 downto 0);

signal deslEsq26to28 : std_logic_vector(31 downto 0);

constant quatro : std_logic_vector(31 downto 0) := (2 => '1', others => '0');

begin

	enablePC <= PCEsc or (PCEscCond and zeroULA); 
	
	regPC					: registrador generic map(32) 
			port map(clock, reset, enablePC, entradaPC, saidaRegPC);
	
	muxPC					: mux2x1nbits generic map(32) 
			port map (saidaRegPC, saidaRegULA, IouD, saidaMuxPC);
	-- Memoria dando erro (Pico resolvendo)
	mem					: memoriaAssinc port map (clock, LerMem, EscMem, dadoEscMem, saidaMuxPC, saidaMem);
	
	regIntrucao			: registrador generic map(32,(others => '0')) 
			port map(clock, reset, IREsc, saidaMem, saidaRegInstr);
	
	muxRegSerEscrito	: mux2x1nbits generic map (5) 
			port map(saidaRegInstr(20 downto 16), saidaRegInstr(15 downto 11), RegDst, saidaMuxRegSerEscrito);
	
	bancoReg				: bancoRegistradores generic map (32, 5) 
			port map(clock, reset, EscReg, saidaRegInstr(25 downto 21), saidaRegInstr(20 downto 16),
						saidaMuxRegSerEscrito, regLido1, regLido2);
																					
	regDadosMemoria	: registrador generic map (32,(others => '0')) port map(clock, reset, '1', saidaMem, saidaRegDadosMem);
	
	muxDadoEscReg		: mux2x1nbits generic map(32) port map (saidaRegULA, saidaRegDadosMem, MemParaReg, dadoEscReg);
	
	regA					: registrador generic map (32,(others => '0')) port map (clock, reset, '1', regLido1, saidaRegA);
	regB					: registrador generic map (32,(others => '0')) port map (clock, reset, '1', regLido2, saidaRegB);
	
	muxAEntradaULA 	: mux2x1nbits generic map(32) 
			port map (saidaRegPC, saidaRegA, ULAFonteA, saidaMuxAULA);
	muxBEntradaULA: mux4x1nbits generic map(32) 
			port map (saidaRegB, quatro, saidaExtensaoSinal, saidaExtensaoSinalDesl, ULAFonteB, saidaMuxBULA);
	
	extensorDeSinal 	: signalExtend generic map (32, 16) port map (saidaRegInstr(15 downto 0), saidaExtensaoSinal);
	
	opULA					: OperacaoULA port map(ULAOp, saidaRegInstr(5 downto 0), ctrlULA);
	
	ulaD					: ula generic map (32) port map (saidaMuxAULA, saidaMuxBULA, ctrlULA, zeroULA, saidaULA);
	
	regSaidaULA			: registrador generic map (32,(others => '0')) port map (clock, reset, '1', saidaULA, saidaRegULA);
	
	muxSaidaULA			: mux4x1nbits generic map (32) 
			port map (saidaULA, saidaRegULA, deslEsq26to28, (others => '0'), FontePC, entradaPC);
	
	saidaExtensaoSinalDesl <= saidaExtensaoSinal(29 downto 0)&"00";
	deslEsq26to28 <= saidaRegPC(31 downto 28)&saidaRegInstr(25 downto 0)&"00";
	opcode <= saidaRegInstr(31 downto 26);

	EnderecoInstrucao	<= saidaRegPC(15 downto 0);
	EnderecoDados		<= saidaRegULA(15 downto 0);
	ValorInstrucao		<= saidaRegInstr(15 downto 0);
	ValorDados			<= saidaRegDadosMem(15 downto 0);
	ValorULA				<= saidaULA(15 downto 0);
end architecture;
