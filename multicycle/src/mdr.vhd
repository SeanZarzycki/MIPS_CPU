library ieee;
use ieee.std_logic_1164.all;

entity MDR is
port(x:in std_logic_vector(31 downto 0);
	clk:in std_logic;
	y:out std_logic_vector(31 downto 0));
end MDR;


architecture behavioral of MDR is
signal reg : std_logic_vector(31 downto 0);
begin
	if rising_edge(clk) then
		reg <= x;
		y <= reg;
	end if;
end behavioral;