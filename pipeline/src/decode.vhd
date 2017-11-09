library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decode is
    port (
        instruction : in std_logic_vector(31 downto 0);
        pc_increment : in std_logic_vector(31 downto 0)

    );

end decode;

architecture beh of decode is

    component control
    port (
        Opcode:in std_logic_vector(5 downto 0);
        RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump:out std_logic;
        ALUOp:out std_logic_vector(1 downto 0));
    end component;

    component registers
    port (
        RR1,RR2,WR:in std_logic_vector(4 downto 0);
        WD:in std_logic_vector(31 downto 0);
        Clk,RegWrite:in std_logic;
        RD1,RD2:out std_logic_vector(31 downto 0));
    end component;

    component signextend
    port(x : in std_logic_vector(15 downto 0);
        y : out std_logic_vector(31 downto 0));
    end component;
 
    component MUX5
    port(x,y : in std_logic_vector (4 downto 0);
         sel : in std_logic;
         z   : out std_logic_vector(4 downto 0));
    end component;

    --    component ShiftLeft2Jump
    --    port(x : in std_logic_vector(25 downto 0);
    --        y : in std_logic_vector(3 downto 0);
    --        z : out std_logic_vector(31 downto 0));
    --    end component;


    begin
    
        MAIN_REGISTERS : registers port map(
            rr1 => Instruction(25 downto 21),
            rr2 => Instruction(20 downto 16),
            wr => B, wd => J, clk => clk, regwrite => RegWrite, rd1 => C, rd2 => D);

        MAIN_CONTROL : Control port map(
            opcode => Instruction(31 downto 26),regdst => RegDst,branch => Branch,
            memread => MemRead, memtoreg => MemtoReg, memwrite => MemWrite, alusrc => ALUSrc,
            regwrite => RegWrite, jump => Jump, aluop => ALUOp);        

        MAIN_SIGNEXTEND : signextend port map(x => Instruction(15 downto 0), y => E);

        M_WRITEREG : MUX5 port map(
            x => Instruction(20 downto 16), 
            y => Instruction(15 downto 11), 
            sel => RegDst, z => B);
            
        -- MAIN_ShiFTLEFT2JUMP : ShiftLeft2Jump port map(
        --     x => Instruction(25 downto 0),L(31 downto 28), Q);
end beh;