library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mem_wb_reg is
port (
    regwrite_in, memtoreg_in : in std_logic;
    
    readdata, gmem, bmem : in std_logic_vector(31 downto 0);
    hwb : out std_logic_vector(31 downto 0);
    gwb : out std_logic_vector(31 downto 0);
    bwb : out std_logic_vector(31 downto 0);
    regwrite_out, memtoreg_out : out std_logic;
    clk : in std_logic
);
end mem_wb_reg;

architecture beh of mem_wb_reg is

begin
    process (clk, bmem, regwrite_in, memtoreg)
    begin
        if rising_edge(clk) then
            bwb <= bmem;
            gwb <= gmem;
            hwb <= readdata;
            regwrite_out <= regwrite_in;
            memtoreg_out <= memtoreg_in;
        end if;
end beh;