library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gshare is
	generic (
		cpu_bits : natural := 32;
		num_counters : natural := 2;
		global_history_size : natural := 32;
	    table_length : natural := 1; -- lg(num_counters)
		bits_per_counter : natural := 2
	);

	port (
		pc : in std_logic_vector(cpu_bits - 1 downto 0);
		taken : in std_logic;
		clk   : in std_logic;
		prediction : out std_logic
	);
end gshare;

architecture beh of gshare is


signal global_history : std_logic_vector(global_history_size - 1 downto 0);
signal gshare_sel     : std_logic_vector(table_length - 1 downto 0);

component counter_table is
	generic (
		num_counters : natural;
	    num_table_length_bits : natural;
		bits_per_counter : natural
	);

	port (
		taken : in std_logic;
		clk   : in std_logic;
		counter_sel : in std_logic_vector(table_length - 1 downto 0);
		prediction : out std_logic
	);
end component;

begin
    
	ctr_table : counter_table
		generic map(
		    num_table_length_bits => table_length,
			num_counters => num_counters,
			bits_per_counter => bits_per_counter
		)
		port map(
			taken => taken,
			clk   => clk,
			counter_sel => gshare_sel,
			prediction => prediction
		);

	process(taken, clk)
	begin
		if rising_edge(clk) then
			global_history <= global_history(global_history_size - 2 downto 0) & taken;
		end if;
	end process;

	process (global_history, pc)
	begin
		gshare_sel <= std_logic_vector(unsigned(pc(table_length - 1 downto 0) xor global_history(table_length - 1 downto 0)));
	end process;

end beh;