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

-- lw $s0, 0($t0)
mem(0) <= "10001101";
mem(1) <= "00010001";
mem(2) <= "00000000";
mem(3) <= "00000000";

-- lw $s1, 4($t0)
mem(4) <= "10001101";
mem(5) <= "00010000";
mem(6) <= "00000000";
mem(7) <= "00000100";

-- slt $t1, $s0, $s1
mem(8) <= "00000010";
mem(9) <= "00010001";
mem(10) <= "01001000";
mem(11) <= "00101010";

-- beq $t1, $zero, L
mem(12) <= "00010001";
mem(13) <= "00100000";
mem(14) <= "00000000";
mem(15) <= "00000010";

-- add $s3, $s4, $s5
mem(16) <= "00000010";
mem(17) <= "10010101";
mem(18) <= "10011000";
mem(19) <= "00100000";

-- j exit
mem(20) <= "00001000";
mem(21) <= "00000000";
mem(22) <= "00000000";
mem(23) <= "00000111";

-- L: sub $s3, $s4, $s5
mem(24) <= "00000010";
mem(25) <= "10010101";
mem(26) <= "10011000";
mem(27) <= "00100010";

-- exit: sw $s3, 8($t0)
mem(28) <= "10101101";
mem(29) <= "00010011";
mem(30) <= "00000000";
mem(31) <= "00001000";

process(Address)
begin

ReadData <= mem(to_integer(unsigned(Address))) & mem(to_integer(unsigned(Address))+1) & mem(to_integer(unsigned(Address))+2) & mem(to_integer(unsigned(Address))+3);

end process;

end behav;