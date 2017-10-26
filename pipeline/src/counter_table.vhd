library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_table is
	generic (
		num_counters : natural := 1024;
		table_length : natural := 32; -- lg(1024)
		bits_per_counter : natural := 2
	);

	port (
		taken : in std_logic;
		counter_sel : in std_logic_vector(table_length - 1 downto 0);
		prediction : out std_logic
	);
end counter_table;

architecture beh of counter_table is

signal pred_bus : std_logic_vector(num_counters - 1 downto 0);
signal prev_taken_bus : std_logic_vector(num_counters - 1 downto 0);

component pred_counter is
	generic (bits : natural := 2);
	port (
		branch_taken : in std_logic;
		take_branch : out std_logic
	);
end component;

begin
	
	GEN_CTR : for i in 0 to num_counters - 1 generate
		ctr : pred_counter 
		    generic map(bits => bits_per_counter)
			port map (take_branch => pred_bus(i), branch_taken => prev_taken_bus(i));
	end generate GEN_CTR;

	process (taken, counter_sel)
	begin
		prev_taken_bus(to_integer(unsigned(counter_sel))) <= taken;
		prediction <= pred_bus(to_integer(unsigned(counter_sel)));
	end process;


end beh;