
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
port(Opcode:in std_logic_vector(5 downto 0);
     RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump:out std_logic;
     ALUOp:out std_logic_vector(1 downto 0));
end Control;

architecture behav of Control is

signal RFormat: std_logic;
signal lw: std_logic;
signal sw: std_logic;
signal beq: std_logic;
signal jum: std_logic;

begin

process(OpCode)
begin

	case OpCode is
		when "000000" =>
				RFormat <= '1';
				lw <= '0';
				sw <= '0';
				beq <= '0';
				jum <= '0';
		when "100011" =>
				RFormat <= '0';
				lw <= '1';
				sw <= '0';
				beq <= '0';
				jum <= '0';
		when "101011" =>
				RFormat <= '0';
				lw <= '0';
				sw <= '1';
				beq <= '0';
				jum <= '0';
		when "000100" =>
				RFormat <= '0';
				lw <= '0';
				sw <= '0';
				beq <= '1';
				jum <= '0';
		when "000010" =>
				RFormat <= '0';
				lw <= '0';
				sw <= '0';
				beq <= '0';
				jum <= '1';
		when others =>
				RFormat <= '0';
				lw <= '0';
				sw <= '0';
				beq <= '0';
				jum <= '0';


	end case; 

end process;

RegDst <= RFormat;
ALUSrc <= lw or sw;
MemtoReg <= lw;
RegWrite <= RFormat or lw;
MemRead <= lw;
MemWrite <= sw;
Branch <= beq;
ALUOp(0) <= beq;
ALUOp(1) <= RFormat;
jump <= jum;

end behav;
