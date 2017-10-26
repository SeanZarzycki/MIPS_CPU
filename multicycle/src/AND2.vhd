library ieee;
use ieee.std_logic_1164.all;
entity AND2 is
port(x,y:in std_logic;z:out std_logic);
end AND2;

architecture behavioral of AND2 is
begin
    process (x, y)
    begin
	z <= x AND y;
	end process;
end behavioral;