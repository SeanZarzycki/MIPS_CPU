library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity NOR_N is
generic (N : integer := 32);
port(x:in std_logic_vector(N-1 downto 0);y:out std_logic);
end NOR_N;

architecture behavioral of NOR_N is
begin
process(x)
	variable temp : std_logic := '0';
begin
	for i in N-1 downto 0 loop
		temp := x(i) OR temp;
	end loop;
	y <= NOT temp;
	temp := '0';
end process;
end behavioral;