library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity if_id_reg is
port(clk:in std_logic;
     LIN,IIN:in std_logic_vector(31 downto 0);
     LOUT,IOUT:out std_logic_vector(31 downto 0));
end if_id_reg;

architecture beh of if_id_reg is

begin
  	process (clk)
    begin
    	if rising_edge(clk) then
        	LOUT <= LIN;
        	IOUT <= IIN;
    	end if;
	end process;
 end beh;
