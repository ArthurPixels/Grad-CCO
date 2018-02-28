----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  <Arthur Mesquita Pickcius>
-- 
-- Create Date: <2017-09-17> 
-- Design Name: 
-- Module Name:    
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity Execution is
	port(
		-- control inputs
		DvC, ULAFonte: in std_logic;
		ULAOp: in std_logic_vector(1 downto 0);
		-- data inputs
		Reg1, Reg2: in std_logic_vector(31 downto 0);
		Cte: in std_logic_vector(15 downto 0);
		-- control outputs
		FontePC: out std_logic;
		-- data outputs
		Result: out std_logic_vector(31 downto 0)
	);
end entity;

architecture HierarchicalStructuralModel of Execution is
	signal sigZero: std_logic;
	signal OPula: std_logic_vector(2 downto 0);
	signal muxReg2,ExtSig: std_logic_vector(31 downto 0);
	
	component ula
	generic(width: positive := 14);
	port(
		a, b: in std_logic_vector(width-1 downto 0);
		op: in std_logic_vector(2 downto 0);  --000:AND , 001:OR , 010:ADD, 110:SUB, 111:SLT
		zero: out std_logic;
		res: out std_logic_vector(width-1 downto 0)
	);
	end component;
	
	component operacaoULA
	port(
		ULAOp: in std_logic_vector(1 downto 0);
		Funct: in std_logic_vector(5 downto 0);
		op: out std_logic_vector(2 downto 0)
	);
	end component;
	
	component mux2x1nbits
	generic(width: integer := 4);
	port(
		inpt0: in std_logic_vector(width-1 downto 0);
		inpt1: in std_logic_vector(width-1 downto 0);
		sel: in std_logic;
		outp: out std_logic_vector(width-1 downto 0)
	);
	end component;
	
	component signalExtend
	generic(	finalWidth:  integer := 12;
				actualWidth: integer := 6);
	port(
		input:  in  std_logic_vector(actualWidth-1 downto 0);
		output: out std_logic_vector(finalWidth-1 downto 0)
	);
	end component;
	
begin
	C0: ula generic map (width => 32) port map (Reg1,muxReg2,OPula,sigZero,Result);
	C1: operacaoULA port map (ULAOp,Cte(5 downto 0),OPula);
	C2: mux2x1nbits generic map (width => 32) port map (Reg2,ExtSig,ULAFonte,muxReg2);
	C3: signalExtend generic map (actualWidth => 16, finalWidth => 32) port map (Cte(15 downto 0),ExtSig);
	FontePC <= DvC and sigZero;
end architecture;