library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity execute is


end execute;


architecture beh of execute is

    -- Components --
    component ALU
        generic (n : natural := 32);
        port (
            a,b:in std_logic_vector(n-1 downto 0);
            Oper:in std_logic_vector(3 downto 0);
            Result:out std_logic_vector(n-1 downto 0);
            Zero,Overflow:out std_logic);
    end component;
 
    component ALUControl
        port (
            ALUOp:in std_logic_vector(1 downto 0);
            Funct:in std_logic_vector(5 downto 0);
            Operation:out std_logic_vector(3 downto 0));
    end component;

    component ShiftLeft2
    port(x:in std_logic_vector(31 downto 0); 
        y:out std_logic_vector(31 downto 0));
    end component;

    component MUX32
    port(x,y : in std_logic_vector (31 downto 0);
         sel : in std_logic;
         z	 : out std_logic_vector(31 downto 0));
    end component;
 
    begin

        PRIMARY_ALU : ALU port map(
            a => C, b => F, oper => Operation, 
            result => G, zero => Zero, overflow => overflow);

        PC_ALU : ALU port map(
            a => L, b => K, 
            oper => "0010", result => M, 
            zero => open, overflow => open);
        
        ALU_CONTROL : ALUControl port map(
            aluop => ALUOp, funct => Instruction(5 downto 0), operation => Operation);
        
        MAIN_SHIFTLEFT2 : ShiftLeft2 port map(
            x => E, y => K);
        
        M_REG_SIGNEXTEND : MUX32 port map(x => D, y => E, sel => ALUSrc, z => F);
        
end beh;