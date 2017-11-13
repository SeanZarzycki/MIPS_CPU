library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity id_ex_reg is
port(clk:in std_logic;
     WBCTRLIN:in std_logic_vector(1 downto 0);
     MCTRLIN:in std_logic_vector(2 downto 0);
     EXCTRLIN:in std_logic_vector(3 downto 0);
     LIN,CIN,DIN,EIN:in std_logic_vector(31 downto 0);
     RTIN,RDIN:in std_logic_vector(4 downto 0);
     WBCTRLOUT:out std_logic_vector(1 downto 0);
     MCTRLOUT:out std_logic_vector(2 downto 0);
     EXCTRLOUT:out std_logic_vector(3 downto 0);
     LOUT,COUT,DOUT,EOUT:out std_logic_vector(31 downto 0);
     RTOUT,RDOUT:out std_logic_vector(4 downto 0)
    );

end id_ex_reg;

architecture beh of id_ex_reg is

begin
  	process (clk)
    begin
    	if rising_edge(clk) then
        	WBCTRLOUT <= WBCTRLIN;
        	MCTRLOUT <= MCTRLIN;
        	EXCTRLOUT <= EXCTRLIN;
        	LOUT <= LIN;
        	COUT <= CIN;
        	DOUT <= DIN;
        	EOUT <= EIN;
        	RTOUT <= RTIN;
        	RDOUT <= RDIN;
    	end if;
	end process;
 end beh;
