library ieee;
use ieee.std_logic_1164.all;

entity FULL_ADDER is
port(
	a,b,CarryIn : in std_logic;
	sum,CarryOut : out std_logic);
end FULL_ADDER;

architecture behavioral of FULL_ADDER is
begin
	CarryOut <= (b AND CarryIn) OR (a AND CarryIn) OR (b AND a);
	sum <= (a AND NOT(b) AND NOT(CarryIn)) OR (NOT(a) AND b and NOT(CarryIn))
			OR (NOT(a) AND NOT(b) AND CarryIn) or (a AND b AND CarryIn);
end behavioral;