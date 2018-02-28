library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity blocoControle  is 
   port(
      clock, reset: in std_logic;
      PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA: out std_logic;
      ULAFonteB, ULAOp, FontePC: out std_logic_vector(1 downto 0);
      opcode: in std_logic_vector(5 downto 0);
		estadoControle: out std_logic_vector(3 downto 0)
   );
end entity;

architecture FSMcomportamental of blocoControle is
	type estado is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);
	signal proximoEstado, estadoAtual : estado;
	constant lw 	: std_logic_vector(5 downto 0) := "100011";
	constant sw 	: std_logic_vector(5 downto 0) := "101011";
	constant tipoR : std_logic_vector(5 downto 0) := "000000"; 
	constant beq 	: std_logic_vector(5 downto 0) := "000100";
	constant jump 	: std_logic_vector(5 downto 0) := "000010";
	
begin
-- state register
	process(clock,reset)
	begin
		if reset = '1' then 
			estadoAtual <= s0;
		elsif rising_edge(clock) then
			estadoAtual <= proximoEstado;
		end if;
	end process;
	
-- next state logic
	process(clock,estadoAtual,opcode)
	begin
		proximoEstado <= estadoAtual;
		case estadoAtual is
			when s0 => 
				proximoEstado <= s1;
			when s1 =>
				if opcode = tipoR then
					proximoEstado <= s6;
				elsif (opcode = lw) or (opcode = sw) then
					proximoEstado <= s2;
				elsif opcode = beq then
					proximoEstado <= s8;
				elsif opcode = jump then
					proximoEstado <= s9;
				end if;
			when s2 =>
				if opcode = lw then
					proximoEstado <= s3;
				else
					proximoEstado <= s5;
				end if;
			when s3 =>
				proximoEstado <= s4;
			when s4 => 
				proximoEstado <= s0;
			when s5 =>
				proximoEstado <= s0;
			when s6 =>
				proximoEstado <= s7;
			when s7 =>
				proximoEstado <= s0;
			when s8 =>
				proximoEstado <= s0;
			when s9 =>
				proximoEstado <= s0;
		end case;
	end process;
	
-- output logic
	process(clock, estadoAtual)
	begin
		PCEscCond <= '0';
		PCEsc <= '0';
		IouD <= '0';
		LerMem <= '0';
		EscMem <= '0';
		MemParaReg <= '0';
		IREsc <= '0';
		RegDst <= '0';
		EscReg <= '0';
		ULAFonteA <= '0';
		ULAFonteB <= "00";
		ULAOp <= "00";
		FontePC <= "00";
		
		case estadoAtual is
			when s0 =>
				LerMem <= '1';
				IREsc <= '1';
				ULAFonteB <= "01";
				PCEsc <= '1';
				estadoControle <= "0000";
			when s1 =>
				ULAFonteB <= "11";
				estadoControle <= "0001";
			when s2 =>
				ULAFonteA <= '1';
				ULAFonteB <= "10";
				estadoControle <= "0010";
			when s3 =>
				LerMem <= '1';
				IouD <= '1';
				estadoControle <= "0011";
			when s4 =>
				EscReg <= '1';
				MemParaReg <= '1';
				estadoControle <= "0100";
			when s5 =>
				EscMem <= '1';
				IouD <= '1';
				estadoControle <= "0101";
			when s6 =>
				ULAFonteA <= '1';
				ULAOp <= "10";
				estadoControle <= "0110";
			when s7 =>
				RegDst <= '1';
				EscReg <= '1';
				estadoControle <= "0111";
			when s8 =>
				ULAFonteA <= '1';
				ULAOp <= "01";
				PCEscCond <= '1';
				FontePC <= "01";
				estadoControle <= "1000";
			when s9 =>
				PCEsc <= '1';
				FontePC <= "10";
				estadoControle <= "1001";
		end case;
	end process;
end architecture;