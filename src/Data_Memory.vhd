library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity DataMemory is 
generic(n:natural := 8;
		l:natural := 8);

port(WriteData: in std_logic_vector(31 downto 0);
	Address: in std_logic_vector(31 downto 0);
	Clk, MemRead, MemWrite: in std_logic;
	ReadData: out std_logic_vector(31 downto 0));
end DataMemory;

architecture struc of DataMemory is 

type vector_array is array (natural range <>) of std_logic_vector(n-1 downto 0);
signal w: vector_array(2**l-1 downto 0);
signal z: std_logic_vector(31 downto 0);


begin

process(Clk, MemRead)
variable i : natural;
variable count:integer:=0;
begin
   i := to_integer(unsigned(address));
	if count = 0 then
		w(4)<=x"00";
		w(5)<=x"00";
		w(6)<=x"00";
		w(7)<=x"04";
		w(8)<=x"00";
		w(9)<=x"00";
		w(10)<=x"00";
		w(11)<=x"05";

		count:=1;
	end if;

if clk'event and clk='1' then
--	i := conv_integer(Address);

	if MemWrite = '1' then
		w(i) <= WriteData(7 downto 0);
		w(i+1) <= WriteData (15 downto 8);
		w(i+2) <= WriteData (23 downto 16);
		w(i+3) <= WriteData (31 downto 24);
	end if;

end if;
	if MemRead = '1' then
   ReadData(7 downto 0)<= w(i);
   ReadData(15 downto 8)<= w(i+1);
   ReadData(23 downto 16)<= w(i+2);
   ReadData(31 downto 24)<= w(i+3);
      --ReadData <= z;
	 end if;
   -- if MemRead = '1' then
      -- ReadData(7 downto 0)<= w(i);
      -- ReadData(15 downto 8)<= w(i+1);
      -- ReadData(23 downto 16)<= w(i+2);
      -- ReadData(31 downto 24)<= w(i+3);
   -- end if;
end process;

-- process(memread)
-- begin
   -- if MemRead = '1' then
      -- ReadData(7 downto 0)<= w(i);
      -- ReadData(15 downto 8)<= w(i+1);
      -- ReadData(23 downto 16)<= w(i+2);
      -- ReadData(31 downto 24)<= w(i+3);
   -- end if;
-- end process;
end struc;