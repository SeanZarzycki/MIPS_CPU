library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity RegB is
 port (clk:in STD_LOGIC; 
       x:in STD_LOGIC_VECTOR (31 downto 0);
	   y:out STD_LOGIC_VECTOR (31 downto 0));
end RegB;

architecture Behavioral of RegB is
signal reg:std_logic_vector(31 downto 0);

begin
  process(clk,x)
    begin
        if clk='1' and clk'event then  
          reg<=x;
        end if;
        if clk='0' and clk'event then
          y<=reg;
        end if;
  end process;
end Behavioral;