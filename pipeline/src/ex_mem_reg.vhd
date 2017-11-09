library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ex_mem_reg is
port (
    clk : in std_logic;
    zex : in std_logic;
    memtoreg_in, regwrite_in, memwrite_in, memread_in, branch_in, zmem : in std_logic;
    memtoreg_out, regwrite_out, memwrite_out, memread_out, branch_out : out std_logic;
    gex, bex, mex, dex : in std_logic_vector(31 downto 0);
    mmem, bmem, gmem, dmem : out std_logic_vector(31 downto 0)
);
end ex_mem_reg;

architecture beh of ex_mem_reg is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            bmem <= bex;
            dmem <= dex;
            mmem <= mex;
            bmem <= bex;
            memtoreg_out <= memtoreg_in;
            regwrite_out <= regwrite_in;
            memwrite_out <= memwrite_in;
            branch_out <= branch_in;
            memread_out <= memread_in;
            zmem <= zex;
        end if;
    end process;
end beh;