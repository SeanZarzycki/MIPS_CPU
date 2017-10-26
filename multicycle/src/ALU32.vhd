library ieee;
use ieee.std_logic_1164.all;



entity ALU is
generic(n:natural:=32);
port(a,b:in std_logic_vector(n-1 downto 0);
	  Oper:in std_logic_vector(3 downto 0);
	  Result:out std_logic_vector(n-1 downto 0);
	  Zero, carryOut, Overflow:out std_logic);
end ALU;

architecture structural of ALU is

constant ALU_OP_AND : std_logic_vector(3 downto 0) := "0000";
constant ALU_OP_OR : std_logic_vector(3 downto 0) :=  "0001";
constant ALU_OP_ADD : std_logic_vector(3 downto 0) := "0010";
constant ALU_OP_SUB : std_logic_vector(3 downto 0) := "0110";
constant ALU_OP_SLT : std_logic_vector(3 downto 0) := "0111";
constant ALU_OP_NOR : std_logic_vector(3 downto 0) := "1100";

signal s_ainvert, s_binvert : std_logic;
signal s_carry : std_logic_vector(n downto 0);
signal s_result : std_logic_vector(N-1 downto 0);
signal set : std_logic;
signal less : std_logic_vector(n-1 downto 0);

component ALU1
port(a,b, Binvert, Ainvert,setin:in std_logic;
	CarryIn : in std_logic;
	CarryOut : out std_logic;
	Oper:in std_logic_vector(1 downto 0);
	Result,setout:out std_logic);
end component;

component NOR_N
generic (N : integer := 32);
port(x:in std_logic_vector(N-1 downto 0);y:out std_logic);
end component;

begin
	process(a,b,oper)
	begin
	s_carry(0) <= oper(2);
	less(n-1 downto 1) <= (others => '0');
	s_ainvert <= Oper(3);
	s_binvert <= Oper(2);

	end process;
	ZEROS : NOR_N port map(s_Result, Zero);
	less(0) <= set;
	ALU : for i in 0 to n-2 generate
		ALUGEN : ALU1 port map(a=>a(i),b=>b(i),binvert=>s_binvert,ainvert=>s_ainvert, setin=>less(i),carryin=>s_carry(i), 
			carryout=>s_carry(i+1), Oper=>Oper(1 downto 0), result=>s_Result(i),setout => open );
		end generate ALU;
	ALU_MSB : ALU1 port map(a=>a(n-1), b=>b(n-1), binvert=>s_binvert, ainvert=>s_ainvert, setin=>'0',carryin=>s_carry(n-1),
		carryout=>s_carry(n), oper=>oper(1 downto 0), result=>s_result(n-1), setout=>set);
	overflow <= (s_carry(n) XOR s_carry(n-1));
	carryOut <= s_carry(n);
	result(0) <= s_result(0) xor (s_carry(n) xor s_carry(n-1));
	result(n-1 downto 1) <= s_result(n-1 downto 1);
	
end structural;