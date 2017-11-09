library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_table is
	generic (
		num_counters : natural := 2;
		num_table_length_bits : natural := 1; -- lg(num_counters)
		bits_per_counter : natural := 2
	);

	port (
		taken : in std_logic;
		clk   : in std_logic;
		counter_sel : in std_logic_vector(num_table_length_bits - 1 downto 0);
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
		clk 		 : in std_logic;
		take_branch : out std_logic
	);
end component;

begin
	
	GEN_CTR : for i in 0 to num_counters - 1 generate
		ctr : pred_counter 
		    generic map(bits => bits_per_counter)
			port map (take_branch => pred_bus(i), clk => clk, branch_taken => prev_taken_bus(i));
	end generate GEN_CTR;

	process (clk, taken, counter_sel)
	begin
		if rising_edge(clk) then
			prev_taken_bus(to_integer(unsigned(counter_sel))) <= taken;
			prediction <= pred_bus(to_integer(unsigned(counter_sel)));
		end if;
	end process;



end beh;