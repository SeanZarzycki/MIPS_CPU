library ieee;
use ieee.std_logic_1164.all;

entity CPU is
port(clk:in std_logic; Overflow:out std_logic);
end CPU;

architecture structural of CPU is
signal a, c, d, e, f, g, h, j, k, l, m, n, p, q, Instruction : std_logic_vector(31 downto 0);
signal Operation : std_logic_vector(3 downto 0);
signal b : std_logic_vector(4 downto 0);
signal r, Zero, RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite : std_logic;
signal PC_INCR : std_logic_vector(31 downto 0) := X"00000004";
signal ALUOp : std_logic_vector(1 downto 0);

-- Pipeline registers

-- IF/ID

-- ID/EX

-- EX/MEM

-- MEM/WB

begin

end structural;
   
   



