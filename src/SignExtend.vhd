library ieee;
use ieee.std_logic_1164.all;
entity SignExtend is
port(x : in std_logic_vector(15 downto 0);
	 y : out std_logic_vector(31 downto 0));
end SignExtend;

architecture behavioral of SignExtend is
signal x_s : std_logic_vector(15 downto 0);
signal y_s : std_logic_vector(31 downto 0);
begin
process(x)
begin
	y(31) <= x(15);
	case x(15) is
		when '0' => y <= (others => '0');
		when '1' => y <= (others => '1');
		when others => y <= (others => '0');
	end case;
	y(14 downto 0) <= x(14 downto 0);
end process;

end behavioral;
