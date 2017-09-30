library ieee;
use ieee.std_logic_1164.all;
entity MUX5 is
port(x,y : in std_logic_vector (4 downto 0);
     sel : in std_logic;
     z   : out std_logic_vector(4 downto 0));
end MUX5;

architecture behavioral of MUX5 is

begin
Process(x,y,sel)
begin
	case sel is
		when '0' => z <= x;
		when '1' => z <= y;
		when others => z <= (others => '0');
	end case;
end process;
end behavioral;