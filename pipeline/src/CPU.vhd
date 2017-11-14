library ieee;
use ieee.std_logic_1164.all;

entity CPU is
port(clk:in std_logic; Overflow:out std_logic);
end CPU;

architecture structural of CPU is
signal a, c, d, e, f, g, h, j, k, l, m, n, p, q, Instruction : std_logic_vector(31 downto 0);
signal Operation : std_logic_vector(3 downto 0);
signal b : std_logic_vector(4 downto 0);
signal r, Zero, Jump : std_logic;
signal PC_INCR : std_logic_vector(31 downto 0) := X"00000004";



component control 
port(Opcode:in std_logic_vector(5 downto 0);
     RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump:out std_logic;
     ALUOp:out std_logic_vector(1 downto 0));
end component;

component PC
port(clk 		: in std_logic;
     AddressIn  : in std_logic_vector(31 downto 0);
     AddressOut : out std_logic_vector(31 downto 0));
end component;

component signextend
port(x : in std_logic_vector(15 downto 0);
    y : out std_logic_vector(31 downto 0));
end component;

component registers
port(RR1,RR2,WR:in std_logic_vector(4 downto 0);
       WD:in std_logic_vector(31 downto 0);
       Clk,RegWrite:in std_logic;
       RD1,RD2:out std_logic_vector(31 downto 0));
end component;

component instmemory
port(Address:in std_logic_vector(31 downto 0);
     ReadData:out std_logic_vector(31 downto 0));
end component;

component ALU
generic (n : natural := 32);
port(a,b:in std_logic_vector(n-1 downto 0);
     Oper:in std_logic_vector(3 downto 0);
     Result:out std_logic_vector(n-1 downto 0);
     Zero,Overflow:out std_logic);
end component;

component ALUControl
port(ALUOp:in std_logic_vector(1 downto 0);
     Funct:in std_logic_vector(5 downto 0);
     Operation:out std_logic_vector(3 downto 0));
end component;

component DataMemory
generic(n:natural := 8;
      l:natural := 8);

port(WriteData: in std_logic_vector(31 downto 0);
   Address: in std_logic_vector(31 downto 0);
   Clk, MemRead, MemWrite: in std_logic;
   ReadData: out std_logic_vector(31 downto 0));
end component;


component ShiftLeft2Jump
port(x : in std_logic_vector(25 downto 0);
    y : in std_logic_vector(3 downto 0);
    z : out std_logic_vector(31 downto 0));
end component;

component ShiftLeft2
port(x:in std_logic_vector(31 downto 0); 
    y:out std_logic_vector(31 downto 0));
end component;

component MUX5
port(x,y : in std_logic_vector (4 downto 0);
     sel : in std_logic;
     z   : out std_logic_vector(4 downto 0));
end component;

component MUX32
port(x,y : in std_logic_vector (31 downto 0);
     sel : in std_logic;
     z	 : out std_logic_vector(31 downto 0));
end component;

component AND2
port(x,y:in std_logic;z:out std_logic);
end component;

-- Pipeline Registers --

component if_id_reg is
    port (
        LIF : in std_logic_vector(31 downto 0);
        IIF : in std_logic_vector(31 downto 0);
        LID : out std_logic_vector(31 downto 0);
        IID : out std_logic_vector(31 downto 0);
        clk : in std_logic
        );
  end component;
  


component ex_mem_reg is
port (
    clk : in std_logic;
    zex : in std_logic;
    zmem : out std_logic;
    memtoreg_in, regwrite_in, memwrite_in, memread_in, branch_in : in std_logic;
    memtoreg_out, regwrite_out, memwrite_out, memread_out, branch_out : out std_logic;
    gex, mex, dex : in std_logic_vector(31 downto 0);
    bex : in std_logic_vector(4 downto 0);
    bmem : out std_logic_vector(4 downto 0);
    mmem,  gmem, dmem : out std_logic_vector(31 downto 0)
);
end component;

component id_ex_reg is
    port (
    clk : in std_logic;
    lid, cid, did, eid : in std_logic_vector(31 downto 0);
    lex, cex, dex, eex : out std_logic_vector(31 downto 0);
    rtid, rdid : in std_logic_vector(4 downto 0);
    rtex, rdex : out std_logic_vector(4 downto 0);
    aluop_in : in std_logic_vector(1 downto 0);
    regwrite_in, aluSrc_in, memtoreg_in, regdst_in, branch_in, memread_in, memwrite_in   : in std_logic;
    aluop_out : out std_logic_vector(1 downto 0);
    regwrite_out, alusrc_out, memtoreg_out, regdst_out, branch_out, memread_out, memwrite_out : out std_logic
);
end component;


component mem_wb_reg is
port (
    regwrite_in, memtoreg_in : in std_logic;
    readdata, gmem : in std_logic_vector(31 downto 0);
    bmem : in std_logic_vector(4 downto 0);
    hwb : out std_logic_vector(31 downto 0);
    gwb : out std_logic_vector(31 downto 0);
    bwb : out std_logic_vector(4 downto 0);
    regwrite_out, memtoreg_out : out std_logic;
    clk : in std_logic
);
end component;


-- Pipeline register signals

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
signal RTID : std_logic_vector(4 downto 0);
signal RDID : std_logic_vector(4 downto 0);

signal aluop_id_ex : std_logic_vector(1 downto 0);
signal memtoreg_id_ex, regwrite_id_ex, 
        branch_id_ex, memread_id_ex, memwrite_id_ex, 
        regdst_id_ex, alusrc_id_ex : std_logic;
-- out
signal LEX : std_logic_vector(31 downto 0);
signal CEX : std_logic_vector(31 downto 0);
signal DEX : std_logic_vector(31 downto 0);
signal EEX : std_logic_vector(31 downto 0);
signal RTEX : std_logic_vector(4 downto 0);
signal RDEX : std_logic_vector(4 downto 0);

signal aluop : std_logic_vector(1 downto 0);
signal memtoreg_ex_mem, regwrite_ex_mem, 
    branch_ex_mem, memread_ex_mem, memwrite_ex_mem, 
    regdst,  alusrc : std_logic;
-- EX/MEM
-- in
signal MEX : std_logic_vector(31 downto 0);
signal ZEX : std_logic;
signal GEX : std_logic_vector(31 downto 0);
signal BEX : std_logic_vector(4 downto 0);

-- out
signal MMEM : std_logic_vector(31 downto 0);
signal ZMEM : std_logic;
signal GMEM : std_logic_vector(31 downto 0);
signal DMEM : std_logic_vector(31 downto 0);
signal BMEM : std_logic_vector(4 downto 0);

signal memtoreg_mem_wb, regwrite_mem_wb, 
    branch, memread, memwrite : std_logic;
-- MEM/WB
-- in
signal ReadData : std_logic_vector(31 downto 0);
signal QWB      : std_logic_vector(31 downto 0);

-- out 
signal HWB : std_logic_vector(31 downto 0);
signal GWB : std_logic_vector(31 downto 0);
signal BWB : std_logic_vector(4 downto 0);

signal memtoreg, regwrite : std_logic;

begin

-- IF components
MAIN_PC : PC port map(clk, p, a);
INSTR_MEM : instmemory port map(a, IIF);
PC_ACC : ALU port map(A, PC_INCR, "0010", LIF, open, open);

M_PCSRC : MUX32 port map(LIF, MMEM, R, P);

IF_ID : if_id_reg port map ( 
    LIF => LIF,
    IIF => IIF,
    LID => LID,
    IID => IID,
    clk => clk
);
-- ID components
MAIN_REGISTERS : registers port map(
    rr1 => IID(25 downto 21),
    rr2 => IID(20 downto 16),
    wr => bwb, wd => J, clk => clk, regwrite => RegWrite, rd1 => CID, rd2 => DID
);
MAIN_CONTROL : Control port map(IID(31 downto 26),
RegDst_id_ex, Branch_id_ex, MemRead_id_ex, 
MemtoReg_id_ex,MemWrite_id_ex,ALUSrc_id_ex,
RegWrite_id_ex, jump,  ALUOp_id_ex);

MAIN_SIGNEXTEND : signextend port map(iid(15 downto 0), Eid);


ID_EX : id_ex_reg port map ( 
    clk => clk,
    lid => lid,
    cid => cid,
    did => did,
    lex => lex,
    cex => cex,
    dex => dex,
    eid => eex,
    rtid => iid(20 downto 16),
    rdid => iid(15 downto 11),
    rtex => rtex,
    rdex => rdex,
    regwrite_in => regwrite_id_ex,
    alusrc_in => alusrc_id_ex,
    memtoreg_in => memtoreg_id_ex,
    aluop_in => aluop_id_ex,
    regdst_in => regdst_id_ex,
    branch_in => branch_id_ex,
    memread_in => memread_id_ex,
    memwrite_in => memwrite_id_ex,
    regdst_out => regdst, aluop_out => aluop, alusrc_out => alusrc,
    branch_out => branch_ex_mem, memread_out => memread_ex_mem, memwrite_out => memwrite_ex_mem,
    memtoreg_out => memtoreg_ex_mem, regwrite_out => regwrite_ex_mem
);
-- EX components

PRIMARY_ALU : ALU port map(Cex, F, Operation, Gex, Zex, overflow);
PC_ALU : ALU port map(Lex, K, "0010", Mex, open, open);
ALU_CONTROL : ALUControl port map(ALUOp, eex(5 downto 0), Operation);
MAIN_SHIFTLEFT2 : ShiftLeft2 port map(Eex, K);
M_WRITEREG : MUX5 port map(rtex, rdex, RegDst, Bex);
M_REG_SIGNEXTEND : MUX32 port map(Dex, Eex, ALUSrc, F);
-- MAIN_ShiFTLEFT2JUMP : ShiftLeft2Jump port map(Instruction(25 downto 0),L(31 downto 28), Q);

EX_MEM : ex_mem_reg port map ( 
    clk => clk, zex => zex, 
    memtoreg_in => memtoreg_ex_mem, regwrite_in => regwrite_ex_mem,
    memwrite_in => memwrite_ex_mem, memread_in => memread_ex_mem, branch_in => branch_ex_mem,
    zmem => zmem,
    memtoreg_out => memtoreg_mem_wb, regwrite_out => regwrite_mem_wb, 
    memwrite_out => memwrite, memread_out => memread, branch_out => branch,
    gex => gex, bex => bex, mex => mex, dex => dex,
    mmem => mmem, bmem => bmem, gmem => gmem, dmem => dmem
);
-- MEM components

DATA_MEM : DataMemory port map(Dmem, Gmem, clk, MemRead, MemWrite, H);
BRANCH_AND : AND2 port map(Branch, zmem, R);

MEM_WB : mem_wb_reg port map ( 
    clk => clk,
    regwrite_in => regwrite_mem_wb, memtoreg_in => memtoreg_mem_wb,
    readdata => H, gmem => gmem, bmem => bmem,
    hwb => hwb, gwb => gwb, bwb => bwb, 
    regwrite_out => regwrite, memtoreg_out => memtoreg
);
-- WB components
M_DATA_MEM : MUX32 port map(GWB, HWB, MemtoReg, J);














end structural;
   
   



