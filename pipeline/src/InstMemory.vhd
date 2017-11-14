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

-- I wasn't too sure about some things. Namely first, what to do with the "nop"s
-- that are present in the instructions. I decided that perhaps they are merely
-- something that should be taken care of with clocking, as introducing some zero
-- instructions may make the code not function as planned. Secondly, it was what
-- to do about the codes that did not use all 32 mem spaces that were present. I
-- just filled in zeroes down. Thirdly, I'm horrible with branching/jumping so
-- please someone look at those and make sure they're right.

-- -- Code 1 / 2
-- -- add $s3,$s4,$s5
mem(0) <= x"02";
mem(1) <= x"95";
mem(2) <= x"98";
mem(3) <= x"20";

-- lw $s0,0($t0)
mem(4) <= x"8d";
mem(5) <= x"10";
mem(6) <= x"00";
mem(7) <= x"00";

-- lw $s1,4($t0)
mem(8) <= x"8d";
mem(9) <= x"11";
mem(10) <= x"00";
mem(11) <= x"04";

-- sub $s7,$s4,$s6
mem(12) <= x"02";
mem(13) <= x"96";
mem(14) <= x"b8";
mem(15) <= x"22";

-- sw $s3,8($t0)
mem(16) <= x"ad";
mem(17) <= x"13";
mem(18) <= x"00";
mem(19) <= x"08";

-- -- Code 3
-- -- add $s3,$s4,$s5
-- mem(0) <= x"02";
-- mem(1) <= x"95";
-- mem(2) <= x"98";
-- mem(3) <= x"20";

-- -- lw $s0,0($t0)
-- mem(4) <= x"8d";
-- mem(5) <= x"10";
-- mem(6) <= x"00";
-- mem(7) <= x"00";

-- -- lw $s1,4($t0)
-- mem(8) <= x"8d";
-- mem(9) <= x"11";
-- mem(10) <= x"00";
-- mem(11) <= x"04";

-- -- sub $s7,$s4,$s6
-- mem(12) <= x"02";
-- mem(13) <= x"96";
-- mem(14) <= x"b8";
-- mem(15) <= x"22";

-- -- sw $s3,8($t0)
-- mem(16) <= x"ad";
-- mem(17) <= x"13";
-- mem(18) <= x"00";
-- mem(19) <= x"08";

-- -- sw $s7,8($t0)
-- mem(20) <= x"00";
-- mem(21) <= x"00";
-- mem(22) <= x"00";
-- mem(23) <= x"00";

-- -- 
-- mem(24) <= x"00";
-- mem(25) <= x"00";
-- mem(26) <= x"00";
-- mem(27) <= x"00";

-- -- 
-- mem(28) <= x"00";
-- mem(29) <= x"00";
-- mem(30) <= x"00";
-- mem(31) <= x"00";

-- -- Code 4 / 5 /6
-- -- beq $t1,$t2,L  -- CHECK THIS BRANCH
-- mem(0) <= x"11";
-- mem(1) <= x"2a";
-- mem(2) <= x"00";
-- mem(3) <= x"10";

-- -- add $t3,$s4,$s5
-- mem(4) <= x"02";
-- mem(5) <= x"95";
-- mem(6) <= x"58";
-- mem(7) <= x"20";

-- -- j exit  -- CHECK THIS BRANCH
-- mem(8) <= x"08";
-- mem(9) <= x"00";
-- mem(10) <= x"00";
-- mem(11) <= x"01";

-- -- L sub $t4,$s4,$s5
-- mem(12) <= x"02";
-- mem(13) <= x"95";
-- mem(14) <= x"60";
-- mem(15) <= x"22";

-- -- exit: add $t5,$s4,$s4
-- mem(16) <= x"00";
-- mem(17) <= x"00";
-- mem(18) <= x"00";
-- mem(19) <= x"00";

-- -- 
-- mem(20) <= x"00";
-- mem(21) <= x"00";
-- mem(22) <= x"00";
-- mem(23) <= x"00";

-- -- 
-- mem(24) <= x"00";
-- mem(25) <= x"00";
-- mem(26) <= x"00";
-- mem(27) <= x"00";

-- -- 
-- mem(28) <= x"00";
-- mem(29) <= x"00";
-- mem(30) <= x"00";
-- mem(31) <= x"00";

process(Address)
begin

ReadData <= mem(to_integer(unsigned(Address))) & mem(to_integer(unsigned(Address))+1) & mem(to_integer(unsigned(Address))+2) & mem(to_integer(unsigned(Address))+3);

end process;

end behav;