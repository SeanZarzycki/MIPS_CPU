library ieee;
use ieee.std_logic_1164.all;
entity PC is
port(clk:in std_logic;
     AddressIn:in std_logic_vector(31 downto 0);
     AddressOut:out std_logic_vector(31 downto 0));
end PC;

architecture behavioral of PC is
   signal init : std_logic := '1';
begin
Process (clk)
begin
if clk'event and clk='1' then
   if init='1' then
      AddressOut <= (others => '0');
      init <= '0';
   else
      AddressOut <= AddressIn;
end if;
end if;
end process;
end behavioral;