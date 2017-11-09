library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pred_counter is
	generic (bits : natural := 2);
	port (
		branch_taken : in std_logic;
		clk 		 : in std_logic;
		take_branch : out std_logic
	);
end pred_counter;

architecture beh of pred_counter is
	signal state_vector : std_logic_vector(bits - 1 downto 0);
	
begin
	
	process(branch_taken, clk)
	variable init : boolean := true;
    begin
		if init then
			state_vector <= (bits - 1 downto 0 => '0');
			init := false;
		end if;
		if rising_edge(clk) then
			if (branch_taken = '1' and state_vector /= (bits - 1 downto 0 => '1')) then
				state_vector <= std_logic_vector(unsigned(state_vector) + 1);
			elsif (branch_taken = '0' and state_vector /= (bits - 1 downto 0 => '0')) then
				state_vector <= std_logic_vector(unsigned(state_vector) - 1);
			else null;
			end if;
		end if;

	end process;

	process(state_vector)
	begin
		take_branch <= state_vector(bits - 1);
	end process;
end beh;
