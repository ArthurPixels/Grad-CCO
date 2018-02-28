library ieee;
use ieee.std_logic_1164.all;

entity MipsMulticiclo is
	port(
		clock, reset: in std_logic;
		EnderecoInstrucao, EnderecoDados,
		ValorInstrucao, ValorDados,
		ValorULA: out std_logic_vector(15 downto 0);
		SinaisControle: out std_logic_vector(15 downto 0);
		EstadoControle: out std_logic_vector(3 downto 0) -- pode ser necessario alterar a largura
	);
end;

architecture estrutural of MipsMulticiclo is
	signal PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, 
			IREsc, ULAFonteA, EscReg, RegDst: std_logic;
	signal ULAOp, FontePC, ULAFonteB: std_logic_vector(1 downto 0);
	-- sinais internos
	signal opcode: std_logic_vector(5 downto 0);
	
	-- declaraçao de componentes (BO e BC)
	component blocoOperativo is
		port(
			clock, reset: in std_logic;
			PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA: in std_logic;
			ULAFonteB, ULAOp, FontePC: in std_logic_vector(1 downto 0);
			opcode: out std_logic_vector(5 downto 0);
			EnderecoInstrucao, EnderecoDados,
			ValorInstrucao, ValorDados,
			ValorULA: out std_logic_vector(15 downto 0)
		);
	end component;
 
	component blocoControle  is
		port(
			clock, reset: in std_logic;
			PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA: out std_logic;
			ULAFonteB, ULAOp, FontePC: out std_logic_vector(1 downto 0);
			opcode: in std_logic_vector(5 downto 0);
			estadoControle: out std_logic_vector(3 downto 0)
		);
	end component;
	
	
begin
	SinaisControle <= PCEscCond & PCEsc & IouD & LerMem & EscMem &
				MemParaReg & IREsc & ULAOp & ULAFonteA & EscReg & RegDst &
				FontePC & ULAFonteB;
				
	-- instanciacoes de componentes
	controle: blocoControle port map (clock, reset, PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst,
									EscReg, ULAFonteA, ULAFonteB, ULAOp, FontePC, opcode, EstadoControle);

	operativo: blocoOperativo port map (clock, reset, PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst,
									EscReg, ULAFonteA, ULAFonteB, ULAOp, FontePC, opcode, EnderecoInstrucao, EnderecoDados,
									ValorInstrucao, ValorDados, ValorULA);
end;
	
	
	
	
	
	