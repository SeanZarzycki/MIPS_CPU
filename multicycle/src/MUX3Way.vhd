library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX3Way is
port(w,x,y:in std_logic_vector(31 downto 0);
     sel: in std_logic_vector(1 downto 0);
     z:out std_logic_vector(31 downto 0));
end MUX3Way;

architecture Behavioral of MUX3Way is
begin
  process(sel,w,x,y)
    begin
        if sel="00" then
          z<=w;
        elsif sel="01" then
          z<=x;
        elsif sel="10" then
          z<=y;
        end if;
  end process;
end Behavioral;
