library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MulticycleCPU is
port(clk:in std_logic; CarryOut, Overflow:out std_logic);
end MulticycleCPU;

architecture Behavioral of MulticycleCPU is

  component IR is
    port (
      x: in std_logic_vector(31 downto 0);
      clk, IRWrite: in std_logic;
      y: out std_logic_vector(31 downto 0)
    );
  end component;

  component MDR is
    port (
      x: in std_logic_vector(31 downto 0);
      clk: in std_logic;
      y: out std_logic_vector(31 downto 0)
    );
  end component;

  component MulticycleControl is
    port(
      Opcode: in std_logic_vector(5 downto 0);
      clk: in std_logic;
      RegDst, RegWrite, ALUSrcA, IRWrite, MemtoReg, MemWrite, MemRead, IorD, PCWrite, PCWriteCond: out std_logic;
      ALUSrcB, ALUOp, PCSource: out std_logic_vector(1 downto 0)
    );
  end component;

  component MUX3Way is
    port(
      w, x, y: in std_logic_vector(31 downto 0);
      sel: in std_logic_vector(1 downto 0);
      z:out std_logic_vector(31 downto 0)
    );
  end component;

  component MUX4Way is
    port(
      v, w, x, y: in std_logic_vector(31 downto 0);
      sel: in std_logic_vector(1 downto 0);
      z:out std_logic_vector(31 downto 0)
    );
  end component;

  component PCMulticycle is
    port(
      clk, d: in std_logic;
      AddressIn: in std_logic_vector(31 downto 0);
      AddressOut: out std_logic_vector(31 downto 0)
    );
  end component;

  component RegA is
    port(
      x: in std_logic_vector(31 downto 0);
      clk: in std_logic;
      y: out std_logic_vector(31 downto 0)
    );
  end component;

  component RegB is
    port(
      x: in std_logic_vector(31 downto 0);
      clk: in std_logic;
      y: out std_logic_vector(31 downto 0)
    );
  end component;

  component registers is
    port(
      RR1, RR2, WR: in std_logic_vector(4 downto 0);
      WD: in std_logic_vector(31 downto 0);
      RegWrite: in std_logic;
      RD1, RD2: out std_logic_vector(31 downto 0)
    );
  end component;

  component Memory is
	port(WriteData         : in  std_logic_vector(31 downto 0);
	     Address           : in  std_logic_vector(31 downto 0);
	     MemRead, MemWrite : in  std_logic;
	     ReadData          : out std_logic_vector(31 downto 0));
	end component;

  component Mux5
    port(
      x, y: in std_logic_vector (4 downto 0);
      sel: in std_logic;
      z :out std_logic_vector(4 downto 0)
    );
  end component;

  component Mux32
    port(
      x, y: in std_logic_vector (31 downto 0);
      sel: in std_logic;
      z: out std_logic_vector(31 downto 0)
    );
  end component;

  component And2
  	port(
  		a, b: in std_logic;
  		y: out std_logic
  	);
  end component;

  component Or2 is
    port(
      a, b: in std_logic;
      y: out std_logic
    );
  end component;

  component ALU is
	generic(n : natural:=32);
	port(a, b           : in  std_logic_vector(n-1 downto 0);
		 Oper           : in  std_logic_vector(3 downto 0);
		 Result         : buffer std_logic_vector(n-1 downto 0);
		 Zero, CarryOut, Overflow : buffer std_logic);
  end component;

component ALUControl is
    port(ALUOp:in std_logic_vector(1 downto 0);
	     Funct:in std_logic_vector(5 downto 0);
	     Operation:out std_logic_vector(3 downto 0));
end component;

component SignExtend
    port(
      x: in std_logic_vector(15 downto 0);
      y: out std_logic_vector(31 downto 0)
    );
end component;

component ShiftLeft2
    port(
      x: in std_logic_vector(31 downto 0);
      y: out std_logic_vector(31 downto 0)
    );
  end component;

  component ShiftLeft2Jump
    port(
      x: in std_logic_vector(25 downto 0);
      y: in std_logic_vector(3 downto 0);
      z: out std_logic_vector(31 downto 0)
    );
  end component;

  component ALUOut is
	port(x   : in  std_logic_vector(31 downto 0);
	     clk : in  std_logic;
	     y   : out std_logic_vector(31 downto 0));
  end component;



signal D, W, PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst, Zero: std_logic;
signal C, E, F, G, H, I, J, L, M, N, P, Q, R, S, T, U, V, Instruction: std_logic_vector(31 downto 0);

signal ALUOp, ALUSrcB, PCSource: std_logic_vector(1 downto 0);
signal Operation: std_logic_vector(3 downto 0);
signal K: std_logic_vector(4 downto 0);



begin
  PC_run: PCMulticycle port map(clk, D, C, E);

  Mem_run:  Memory port map(H,G,MemRead,MemWrite,I);
  MDR_run: MDR port map(I, clk, J);
  IR_run: IR port map(I, clk, IRWrite, Instruction);

  Mux5_run: Mux5 port map(Instruction(20 downto 16), Instruction(15 downto 11), RegDst, K);
  Mux32_run: Mux32 port map(E, F, IorD, G);
  Mux32_run_2: Mux32 port map(F, J, MemtoReg, L);
  Mux32_run_3: Mux32 port map(E, P, ALUSrcA, S);
  
  Registers_run: registers port map(Instruction(25 downto 21), Instruction(20 downto 16), K, L, RegWrite, M, N);
  RegA_run: RegA port map(M, clk, P);
  RegA_run_2: RegA port map(N, clk, H);
  RegB_run: RegB port map(U, clk, F);
  ALUOut_run: ALUOut port map(U,clk,F);

  SignExtend_run: SignExtend port map(Instruction(15 downto 0), Q);
  ShiftLeft2_run: ShiftLeft2 port map(Q, R);
  MUX3Way_run: MUX3Way port map(U, F, V, PCSource, C);
  MUX4Way_run: MUX4Way port map(H, X"00000004", Q, R, ALUSrcB, T);

  ShiftLeft2Jump_run: ShiftLeft2Jump port map(Instruction(25 downto 0), E(31 downto 28), V);
  And2_run: And2 port map(Zero, PCWriteCond, W);
  Or2_run: Or2 port map(W, PCWrite, D);
  ALU_run: ALU port map(S, T, Operation, U, Zero, Carryout, Overflow);
  
  ALUControl_run: ALUControl port map(ALUOp, Instruction(5 downto 0), Operation);
  Control_run_all: MulticycleControl port map(Instruction(31 downto 26), clk, RegDst, RegWrite, ALUSrcA, IRWrite, MemtoReg, MemWrite, MemRead, IorD, PCWrite, PCWriteCond, ALUSrcB, ALUOp, PCSource);
end Behavioral;

