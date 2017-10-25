library ieee;
use IEEE.std_logic_1164.all;

entity PCMulticycle is
port(clk,d:in std_logic;
     AddressIn:in std_logic_vector(31 downto 0);
     AddressOut:out std_logic_vector(31 downto 0));
end PCMulticycle;

architecture beh of PCMulticycle is
begin

process(clk, d)
variable flag : boolean := true;
begin

if clk'event and clk = '1' and d = '1' then
	addressOut <= addressIn;
end if;

end process;
end beh;