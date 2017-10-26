library ieee;
use ieee.std_logic_1164.all;
entity OR2 is
port(x,y:in std_logic;z:out std_logic);
end OR2;

architecture behavioral of OR2 is
begin
    process (x, y)
    begin
	z <= x OR y;
	end process;
end behavioral;