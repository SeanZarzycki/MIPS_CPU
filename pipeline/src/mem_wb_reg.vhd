library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mem_wb_reg is
port(clk: in std_logic;
    WBCTRLIN:in std_logic_vector(1 downto 0);
    HIN,DIN:in std_logic_vector(31 downto 0);
    BIN:in std_logic_vector(4 downto 0);
    WBCTRLOUT:out std_logic_vector(1 downto 0);
    HOUT,DOUT:out std_logic_vector(31 downto 0);
    BOUT:out std_logic_vector(4 downto 0));
end mem_wb_reg;

architecture beh of mem_wb_reg is

begin
    process (clk)
    begin
        if rising_edge(clk) then
            WBCTRLOUT <= WBCTRLIN;
            HOUT <= HIN;
            DOUT <= DIN;
            BOUT <= BIN;
        end if;
    end process;
 end beh;
