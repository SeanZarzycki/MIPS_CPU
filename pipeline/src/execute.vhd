library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity execute is

port (
    lex : in std_logic_vector(31 downto 0);
    cex : in std_logic_vector(31 downto 0);
    dex : in std_logic_vector(31 downto 0);
    eex : in std_logic_vector(5 downto 0);
    rtex : in std_logic_vector(31 downto 0);
    rdex : in std_logic_vector(31 downto 0);
    bex : out std_logic_vector(31 downto 0);
    mex : out std_logic_vector(31 downto 0);
    gex : out std_logic_vector(31 downto 0);
    zex : out std_logic_vector(31 downto 0);
    
    regDst, aluSrc : in std_logic;
    aluOp : in std_logic_vector(1 downto 0)

);

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
    
    -- signals
    signal F : std_logic_vector(31 downto 0);
    signal operation : std_logic_vector(3 downto 0);
    begin

        PRIMARY_ALU : ALU port map(
            a => cex, b => , oper => Operation, 
            result => gex, zero => zex, overflow => overflow);

        PC_ALU : ALU port map(
            a => Lex, b => K, 
            oper => "0010", result => mex, 
            zero => open, overflow => open);
        
        ALU_CONTROL : ALUControl port map(
            aluop => ALUOp, funct => eex, operation => Operation);
        
        MAIN_SHIFTLEFT2 : ShiftLeft2 port map(
            x => Eex, y => K);
        
        M_REG_SIGNEXTEND : MUX32 port map(x => dex, y => eex, sel => ALUSrc, z => F);
        M_RTEX_RDEX : MUX32 port map(x => rtex, y => rdex, sel => regdst, z => bex);
end beh;