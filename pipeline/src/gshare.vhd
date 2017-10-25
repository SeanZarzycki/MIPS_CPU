library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gshare is
	generic (
		cpu_bits : natural := 32;
		num_counters : natural := 1024;
		global_history_size : natural := 32;
`		bits_per_counter : natural := 2
	);

	port (
		pc : in std_logic_vector(cpu_bits - 1 downto 0);
		taken : in std_logic;
		prediction : out std_logic
	);
end gshare;

architecture beh of gshare is

signal global_history : std_logic_vector(global_history_size - 1 downto 0);

component counter_table is
	generic (
		num_counters : natural := 1024;
`		bits_per_counter : natural := 2
	);

	port (
		taken : in std_logic;
		counter_sel : in std_logic_vector(log2(num_counters) - 1 downto 0);
		prediction : out std_logic
	);
end component;

begin

	

	ctr_table : counter_table(
		generic map(
			num_counters => num_counters;
			bits_per_counter => bits_per_counter
		);

		port map(
			taken => taken;
			counter_sel => std_logic_vector(to_unsigned(pc xor global_history(cpu_bits - 1 downto 0)) mod num_counters);
			prediction => prediction
		)
	);

	process(pc, taken)
	begin
		global_history <= global_history(global_history_size - 1 downto 1) & taken;
	end process;

end beh;