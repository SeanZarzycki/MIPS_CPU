library ieee;
use ieee.std_logic_1164.all;



entity ALU1 is
port(a,b, Binvert, Ainvert, setin:in std_logic;
	CarryIn : in std_logic;
	CarryOut : out std_logic;
	Oper:in std_logic_vector(1 downto 0);
	Result,setout:out std_logic);
end ALU1;

architecture behavioral of ALU1 is

constant ALU_OP_AND : std_logic_vector(1 downto 0) := "00";
constant ALU_OP_OR : std_logic_vector(1 downto 0) :=  "01";
constant ALU_OP_ADD : std_logic_vector(1 downto 0) := "10";
constant ALU_OP_SLT : std_logic_vector(1 downto 0) := "11";

signal s_b, s_result, s_a, s_addersum : std_logic;
component AND2
	port(x,y:in std_logic;z:out std_logic);
end component;

component FULL_ADDER
	port(a,b,CarryIn : in std_logic; sum,CarryOut : out std_logic);
end component;

begin
	adder : 
		FULL_ADDER port map(a => s_a, b => s_b, CarryIn => CarryIn, CarryOut => CarryOut, sum => s_addersum);
	process(a, b, Binvert, Ainvert, CarryIn, oper, s_addersum,setin)
	begin
	case Binvert is
		when '1' => s_b <= NOT(b);
		when '0' => s_b <= b;
		when others => NULL;
	end case;
	case Ainvert is
		when '1' => s_a <= NOT(a);
		when '0' => s_a <= a;
		when others => NULL;
	end case;	
	
	case oper is
		when ALU_OP_AND=>
			s_Result <= s_a AND s_b;
		when ALU_OP_OR =>
			s_Result <= s_a OR s_b;
		when ALU_OP_ADD =>
			s_Result <= s_addersum;
		when ALU_OP_SLT =>
			s_result <= setin;
		when others => s_result <= '1';
	end case;
	end process;
	result <= s_result;
	setout <= s_addersum;


end behavioral;