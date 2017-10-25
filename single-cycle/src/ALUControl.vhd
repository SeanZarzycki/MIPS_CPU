library ieee;
use ieee.std_logic_1164.all;

entity ALUControl is
port(ALUOp:in std_logic_vector(1 downto 0);
     Funct:in std_logic_vector(5 downto 0);
     Operation:out std_logic_vector(3 downto 0));
end ALUControl;

architecture behavioral of ALUControl is


   constant OP_AND_OR_ADD_SUB_SLT : std_logic_vector(1 downto 0) := "10";
   constant OP_LW_SW : std_logic_vector(1 downto 0) := "00";
   constant OP_BEQ : std_logic_vector(1 downto 0) := "01";

   constant FUNCT_AND : std_logic_vector(5 downto 0) := "100100";
   constant FUNCT_OR : std_logic_vector(5 downto 0) := "100101";
   constant FUNCT_ADD : std_logic_vector(5 downto 0) := "100000";
   constant FUNCT_SUB : std_logic_vector(5 downto 0) := "100010";
   constant FUNCT_SLT : std_logic_vector(5 downto 0) := "101010";

   constant ALU_OP_ERR : std_logic_vector(3 downto 0) := "XUXU";
   constant ALU_OP_AND : std_logic_vector(3 downto 0) := "0000";
   constant ALU_OP_OR : std_logic_vector(3 downto 0) :=  "0001";
   constant ALU_OP_ADD : std_logic_vector(3 downto 0) := "0010";
   constant ALU_OP_SUB : std_logic_vector(3 downto 0) := "0110";
   constant ALU_OP_SLT : std_logic_vector(3 downto 0) := "0111";
   constant ALU_OP_NOR : std_logic_vector(3 downto 0) := "1100";  
   
begin
   
   process(ALUOp, Funct)
   begin
      case(ALUOp) is
         when OP_AND_OR_ADD_SUB_SLT => 
            case(Funct) is
               when FUNCT_AND => operation <= ALU_OP_AND;
               when FUNCT_OR => operation <= ALU_OP_OR;
               when FUNCT_ADD => operation <= ALU_OP_ADD;
               when FUNCT_SUB => operation <= ALU_OP_SUB;
               when FUNCT_SLT => operation <= ALU_OP_SLT;
               when others => NULL;
            end case;
         when OP_LW_SW => operation <= ALU_OP_ADD;
         when OP_BEQ => operation <= ALU_OP_SUB;
         when others => operation <= ALU_OP_ERR;
      end case;
      
   end process;
   
end behavioral;

         
         
         
         
         