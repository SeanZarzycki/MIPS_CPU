library ieee;
use ieee.std_logic_1164.all;
entity MUX32 is
port(x,y : in std_logic_vector (31 downto 0);
     sel : in std_logic;
     z	 : out std_logic_vector(31 downto 0));
end MUX32;

architecture behavioral of MUX32 is

begin
process(x,y,sel)
begin
	case sel is
		when '0' => z <= x;
		when '1' => z <= y;
		when others => z <= (others =>'0');
	end case;
end process;
end behavioral;