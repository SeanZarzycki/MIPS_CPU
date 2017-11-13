library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity if_id_reg is
  port(LIF : in std_logic_vector(31 downto 0);
	     IIF : in std_logic_vector(31 downto 0);
       LID : out std_logic_vector(31 downto 0);
       IID : out std_logic_vector(31 downto 0);
       clk : in std_logic)
      );
end if_id_reg;

architecture beh of if_id_reg is

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
