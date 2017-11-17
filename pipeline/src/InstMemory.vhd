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

-- -- Code 1
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

-- -- Code 2
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

-- -- sw $s7,8($t0)
-- mem(16) <= x"ad";
-- mem(17) <= x"17";
-- mem(18) <= x"00";
-- mem(19) <= x"08";

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

-- -- nop
-- mem(16) <= x"00";
-- mem(17) <= x"00";
-- mem(18) <= x"00";
-- mem(19) <= x"00";

-- -- nop
-- mem(20) <= x"00";
-- mem(21) <= x"00";
-- mem(22) <= x"00";
-- mem(23) <= x"00";

-- -- nop
-- mem(24) <= x"00";
-- mem(25) <= x"00";
-- mem(26) <= x"00";
-- mem(27) <= x"00";

-- -- sw $s7,8($t0)
-- mem(28) <= x"ad";
-- mem(29) <= x"17";
-- mem(30) <= x"00";
-- mem(31) <= x"08";


-- Code 4
-- -- beq $t1,$t2,L  -- CHECK THIS BRANCH
-- mem(0) <= x"11";
-- mem(1) <= x"2a";
-- mem(2) <= x"00";
-- mem(3) <= x"10";

-- -- nop
-- mem(4) <= x"00";
-- mem(5) <= x"00";
-- mem(6) <= x"00";
-- mem(7) <= x"00";

-- -- nop
-- mem(4) <= x"00";
-- mem(5) <= x"00";
-- mem(6) <= x"00";
-- mem(7) <= x"00";

-- -- add $t3,$s4,$s5
-- mem(8) <= x"02";
-- mem(9) <= x"95";
-- mem(10) <= x"58";
-- mem(11) <= x"20";

-- -- j exit  -- CHECK THIS BRANCH
-- mem(12) <= x"08";
-- mem(13) <= x"00";
-- mem(14) <= x"00";
-- mem(15) <= x"01";

-- -- nop
-- mem(16) <= x"00";
-- mem(17) <= x"00";
-- mem(18) <= x"00";
-- mem(19) <= x"00";

-- -- L sub $t4,$s4,$s5
-- mem(20) <= x"02";
-- mem(21) <= x"95";
-- mem(22) <= x"60";
-- mem(23) <= x"22";

-- -- exit: add $t5,$s4,$s4
-- mem(24) <= x"02";
-- mem(25) <= x"94";
-- mem(26) <= x"68";
-- mem(27) <= x"20";

-- -- Code 5
-- -- beq $t1,$t2,L  -- CHECK THIS BRANCH
-- mem(0) <= x"11";
-- mem(1) <= x"2a";
-- mem(2) <= x"00";
-- mem(3) <= x"06";

-- -- nop
-- mem(4) <= x"00";
-- mem(5) <= x"00";
-- mem(6) <= x"00";
-- mem(7) <= x"00";

-- -- nop
-- mem(8) <= x"00";
-- mem(9) <= x"00";
-- mem(10) <= x"00";
-- mem(11) <= x"00";

-- -- nop
-- mem(12) <= x"00";
-- mem(13) <= x"00";
-- mem(14) <= x"00";
-- mem(15) <= x"00";

-- -- add $t3,$s4,$s5
-- mem(16) <= x"02";
-- mem(17) <= x"95";
-- mem(18) <= x"58";
-- mem(19) <= x"20";

-- -- j exit  -- CHECK THIS BRANCH
-- mem(20) <= x"08";
-- mem(21) <= x"00";
-- mem(22) <= x"00";
-- mem(23) <= x"08";

-- -- nop
-- mem(24) <= x"00";
-- mem(25) <= x"00";
-- mem(26) <= x"00";
-- mem(27) <= x"00";

-- -- L sub $t4,$s4,$s5
-- mem(28) <= x"02";
-- mem(29) <= x"95";
-- mem(30) <= x"60";
-- mem(31) <= x"22";

-- -- exit: add $t5,$s4,$s4
-- mem(32) <= x"02";
-- mem(33) <= x"94";
-- mem(34) <= x"68";
-- mem(35) <= x"20";

-- Code 6
-- beq $t1,$t2,L  -- CHECK THIS BRANCH
mem(0) <= x"11";
mem(1) <= x"2a";
mem(2) <= x"00";
mem(3) <= x"10";

-- nop
mem(4) <= x"00";
mem(5) <= x"00";
mem(6) <= x"00";
mem(7) <= x"00";

-- nop
mem(8) <= x"00";
mem(9) <= x"00";
mem(10) <= x"00";
mem(11) <= x"00";

-- add $t3,$s4,$s5
mem(12) <= x"02";
mem(13) <= x"95";
mem(14) <= x"58";
mem(15) <= x"20";

-- j exit  -- CHECK THIS BRANCH
mem(16) <= x"08";
mem(17) <= x"00";
mem(18) <= x"00";
mem(19) <= x"01";

-- nop
mem(20) <= x"00";
mem(21) <= x"00";
mem(22) <= x"00";
mem(23) <= x"00";

-- L sub $t4,$s4,$s5
mem(24) <= x"02";
mem(25) <= x"95";
mem(26) <= x"60";
mem(27) <= x"22";

-- exit: add $t5,$s4,$s4
mem(28) <= x"02";
mem(29) <= x"94";
mem(30) <= x"68";
mem(31) <= x"20";

process(Address)
begin

ReadData <= mem(to_integer(unsigned(Address))) & mem(to_integer(unsigned(Address))+1) & mem(to_integer(unsigned(Address))+2) & mem(to_integer(unsigned(Address))+3);

end process;

end behav;