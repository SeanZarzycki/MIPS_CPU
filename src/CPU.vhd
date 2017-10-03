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

   component control 
   port(Opcode:in std_logic_vector(5 downto 0);
        RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump:out std_logic;
        ALUOp:out std_logic_vector(1 downto 0));
   end component;

   component PC
   port( clk 		: in std_logic;
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

begin
   
   MAIN_PC : PC port map(clk, p, a);
   INSTR_MEM : instmemory port map(a, Instruction);
   MAIN_REGISTERS : registers port map(Instruction(25 downto 21),Instruction(20 downto 16),B,J,clk, RegWrite, C, D);
   PRIMARY_ALU : ALU port map(C, F, Operation, G, Zero, overflow);
   DATA_MEM : DataMemory port map(D, G, clk, MemRead, MemWrite, H);
   MAIN_CONTROL : Control port map(Instruction(31 downto 26),RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump, ALUOp);
   ALU_CONTROL : ALUControl port map(ALUOp, Instruction(5 downto 0), Operation);
   MAIN_SHIFTLEFT2 : ShiftLeft2 port map(E, K);
   MAIN_ShiFTLEFT2JUMP : ShiftLeft2Jump port map(Instruction(25 downto 0),L(31 downto 28), Q);
   MAIN_SIGNEXTEND : signextend port map(Instruction(15 downto 0), E);
   PC_ALU : ALU port map(L, K, "0010", M, open, open);
   PC_ACC : ALU port map(A, PC_INCR, "0010", L, open, open);
   BRANCH_AND : AND2 port map(Branch, Zero, R);
   
   -- MUXES 
   M_REG_SIGNEXTEND : MUX32 port map(D, E, ALUSrc, F);
   M_DATA_MEM : MUX32 port map(G, H, MemtoReg, J);
   M_L_M : MUX32 port map(L, M,R, N);
   M_JUMP : MUX32 port map(N, Q, Jump, P);
   M_WRITEREG : MUX5 port map(Instruction(20 downto 16), Instruction(15 downto 11), RegDst, B);
   
end structural;
   
   



