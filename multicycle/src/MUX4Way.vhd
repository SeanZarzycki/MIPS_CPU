library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4Way is
port(v,w,x,y:in std_logic_vector(31 downto 0);
    sel: in std_logic_vector(1 downto 0);
    z:out std_logic_vector(31 downto 0));
end MUX4Way;

architecture Behavioral of MUX4Way is
begin
  process(sel,v,w,x,y)
    begin
        if sel="00" then
          z<=v;
        elsif sel="01" then
          z<=w;
        elsif sel="10" then
          z<=x;
        elsif sel="11" then
          z<=y;
        end if;
  end process;
end Behavioral;