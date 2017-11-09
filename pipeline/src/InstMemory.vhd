library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstMemory is
port(Address:in std_logic_vector(31 downto 0);
	ReadData:out std_logic_vector(31 downto 0));
end InstMemory;

architecture behav of InstMemory is

type MemArray is array(0 to 256) of std_logic_vector(7 downto 0);
signal mem : MemArray;
begin

-- lw $s5, 0($t0)
mem(0) <= "10001101";
mem(1) <= "00010101";
mem(2) <= "00000000";
mem(3) <= "00000000";

-- lw $s1, 4($t0)
mem(4) <= "10001101";
mem(5) <= "00010110";
mem(6) <= "00000000";
mem(7) <= "00000100";

-- slt $t7, $s5, $s6
mem(8) <= "00000010";
mem(9) <= x"b6";
mem(10) <= x"78";
mem(11) <= x"2a";

-- beq $t7, $zero, L
mem(12) <= "00010001";
mem(13) <= x"e0";
mem(14) <= "00000000";
mem(15) <= "00000010";

-- sub $s1, $s2, $s3
mem(16) <= "00000010";
mem(17) <= x"53";
mem(18) <= x"88";
mem(19) <= x"22";

-- j exit
mem(20) <= "00001000";
mem(21) <= "00000000";
mem(22) <= "00000000";
mem(23) <= "00000111";

-- L: add $s1, $s2, $s3
mem(24) <= "00000010";
mem(25) <= x"53";
mem(26) <= x"88";
mem(27) <= x"20";

-- exit: sw $s1, 12($t0)
mem(28) <= x"ad";
mem(29) <= x"11";
mem(30) <= x"00";
mem(31) <= x"0c";

process(Address)
begin

ReadData <= mem(to_integer(unsigned(Address))) & mem(to_integer(unsigned(Address))+1) & mem(to_integer(unsigned(Address))+2) & mem(to_integer(unsigned(Address))+3);

end process;

end behav;