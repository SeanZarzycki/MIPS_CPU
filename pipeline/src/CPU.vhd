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

-- Pipeline Stages --
component fetch is
    port (
        clk      : in std_logic;
        lif, iif : out std_logic_vector(31 downto 0);
        pcsrc : in std_logic;
        mmem : in std_logic_vector(31 downto 0)
    );
end component;

component decode is
    port (
        
        instruction : in std_logic_vector(31 downto 0);
        pc_increment : in std_logic_vector(31 downto 0);
        regwrite : in std_logic;
        cid, did : out std_logic_vector(31 downto 0);
        eid : out std_logic_vector(31 downto 0);
        rtid : out std_logic_vector(4 downto 0);
        rdid : out std_logic_vector(4 downto 0)

    );

end component;

component execute is
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

end component;

component mem is
    port (
        mmem : in std_logic_vector(31 downto 0);
        memwrite, memread : in std_logic;
        r : out std_logic;
        bmem_in : in std_logic_vector(31 downto 0);
        bmem_out : out std_logic_vector(31 downto 0)

    );
end component;

component writeback is
port (
    hwb, gwb : in std_logic_vector(31 downto 0);
    memtoreg : in std_logic;
    j : out std_logic_vector(31 downto 0)
);
end component;






-- Pipeline registers

-- IF/ID
signal LIF : std_logic_vector(31 downto 0);
signal IIF : std_logic_vector(31 downto 0);

-- ID/EX
-- in
signal LID : std_logic_vector(31 downto 0);
signal IID : std_logic_vector(31 downto 0);
signal CID : std_logic_vector(31 downto 0);
signal DID : std_logic_vector(31 downto 0);
signal EID : std_logic_vector(31 downto 0);
signal RTID : std_logic_vector(31 downto 0);
signal RDID : std_logic_vector(31 downto 0);
-- out
signal LEX : std_logic_vector(31 downto 0);
signal CEX : std_logic_vector(31 downto 0);
signal DEX : std_logic_vector(31 downto 0);
signal EEX : std_logic_vector(31 downto 0);
signal RTEX : std_logic_vector(31 downto 0);
signal RDEX : std_logic_vector(31 downto 0);
-- EX/MEM
-- in
signal MEX : std_logic_vector(31 downto 0);
signal ZEX : std_logic_vector(31 downto 0);
signal QEX : std_logic_vector(31 downto 0);
signal BEX : std_logic_vector(31 downto 0);

-- out
signal MMEM : std_logic_vector(31 downto 0);
signal ZMEM : std_logic_vector(31 downto 0);
signal QMEM : std_logic_vector(31 downto 0);
signal DMEM : std_logic_vector(31 downto 0);
signal BMEM : std_logic_vector(31 downto 0);

-- MEM/WB
-- in
signal ReadData : std_logic_vector(31 downto 0);
signal QWB      : std_logic_vector(31 downto 0);

-- out 
signal HWB : std_logic_vector(31 downto 0);
signal GWB : std_logic_vector(31 downto 0);
signal BWB : std_logic_vector(31 downto 0);
begin

    fetch_stage : fetch port map (
        clk => clk,
        lif => lif,
        iif => iif,
        pcsrc => pcsrc,
        mmem => mmem
    );

    decode_stage : decode port map (
        instruction => iid,
        pc_increment => lid,
        regwrite => 
    );


end structural;
   
   



