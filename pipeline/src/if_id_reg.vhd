library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity if_id_reg is
  port(LIF : in std_logic_vector(31 downto 0);
	     IIF : in std_logic_vector(31 downto 0);
       LID : out std_logic_vector(31 downto 0);
       IID : out std_logic_vector(31 downto 0);
       clk : in std_logic
      );
end if_id_reg;

architecture beh of if_id_reg is

begin
    process (clk)
    begin
        if rising_edge(clk) then
            lid <= lif;
            iid <= lif;
        end if;
    end process;
end beh;
