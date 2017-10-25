library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memory is
port(WriteData:in std_logic_vector(31 downto 0);
     Address:in std_logic_vector(31 downto 0);
     MemRead,MemWrite:in std_logic;
     ReadData:out std_logic_vector(31 downto 0));
end Memory;

architecture beh of Memory is
type memory_array is array(natural range <>) of std_logic_vector(7 downto 0);
signal sig_memory: memory_array(0 to 63);
begin

process(Address, MemRead, MemWrite,sig_memory)
variable mem: memory_array(0 to 63) :=
	("10001101", "00010000", "00000000", "00101000", -- lw $s0, 40($t0) / 0
	"10001101", "00010001", "00000000", "00101100", -- lw $s1, 44($t0) / 4
	"00010010", "00010001", "00000000", "00010100", -- beq $s0,$s1,L / 8
	"00000010", "10010101", "10011000", "00100000", -- add $s3,$s4,$s5 / 12
	"00001000", "00000000", "00000000", "00011000", -- j exit / 16
	"00000010", "10010101", "10011000", "00100010", -- sub $s3,$s4,$s5 / 20 (L)
	"10101101", "00010011", "00000000", "00110000", -- sw $s3, 48($t0) / 24 (exit)
	"UUUUUUUU", "UUUUUUUU", "UUUUUUUU", "UUUUUUUU", -- 28
	"UUUUUUUU", "UUUUUUUU", "UUUUUUUU", "UUUUUUUU", -- 32
	"UUUUUUUU", "UUUUUUUU", "UUUUUUUU", "UUUUUUUU", -- 36
	"00000000", "00000000", "00000000", "00000100", -- 4 / 40
	"00000000", "00000000", "00000000", "00000100", -- 4 / branch taken 44
	--"11111111", "11111111", "11111111", "11111011", -- -5 / branch untaken 44
	others=>("UUUUUUUU"));
begin

if MemRead /= '1' and MemWrite = '1' then
	mem(conv_integer(Address)) := WriteData(31 downto 24);
	mem(conv_integer(Address)+1) := WriteData(23 downto 16);
	mem(conv_integer(Address)+2) := WriteData(15 downto 8);
	mem(conv_integer(Address)+3) := WriteData(7 downto 0);
	ReadData <= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
elsif MemRead = '1' and MemWrite /= '1' and Address /= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then
	ReadData <= mem(conv_integer(Address)) & mem(conv_integer(Address)+1) & mem(conv_integer(Address)+2) & mem(conv_integer(Address)+3);
else
	ReadData <= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
end if;
sig_memory <= mem;

end process;
end beh;
