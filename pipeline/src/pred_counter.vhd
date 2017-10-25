library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pred_counter is
	generic (bits : natural := 2);
	port (
		branch_taken : in std_logic;
		take_branch : out std_logic;
	);
end pred_counter;

architecture beh of pred_counter is
	signal state_vector : std_logic_vector(bits - 1 downto 0);
begin
	
	process(branch_taken)
		if (branch_taken = '1' and state_vector /= (others => 1)) then
			state_vector <= std_logic_vector(to_unsigned(state_vector) + 1);
		elsif (branch_taken = '0' and state_vector /= (others => 0)) then
			state_vector <= std_logic_vector(to_unsigned(state_vector) - 1);
		else null;
		end if;
	end process;

end beh;
