library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers is
  port(RR1,RR2,WR:in std_logic_vector(4 downto 0);
       WD:in std_logic_vector(31 downto 0);
       Clk,RegWrite:in std_logic;
       RD1,RD2:out std_logic_vector(31 downto 0));
end registers;

architecture structural of registers is

constant zero : integer := 0;
constant t0 : integer := 8;
constant t1 : integer := 9;
constant t2 : integer := 10;
constant s1 : integer := 17;
constant s2 : integer := 18;
constant s3 : integer := 19;
constant s4 : integer := 20;
constant s5 : integer := 21;
constant s6 : integer := 22;
constant s7 : integer := 23;

type reg is array (31 downto 0) of std_logic_vector(31 downto 0);
signal RF : reg; 
signal s_WR, s_RR1, s_RR2 : natural;

   
begin

    process (clk,RR1,RR2,WR,WD,RegWrite)

    variable init : boolean := true;
    begin
        s_WR <= to_integer(unsigned(WR));
        s_RR1 <= to_integer(unsigned(RR1));
        s_RR2 <= to_integer(unsigned(RR2));
        if (init) then
            RF(zero) <= std_logic_vector(to_unsigned(0, 32));
            RF(t0)<=(others=>'0');
            RF(t1)<="00000000000000000000000000000100";
            RF(t2)<="00000000000000000000000000000100";
            RF(s4)<="00000000000000000000000000001110";
            RF(s5)<="00000000000000000000000000000101";
            RF(s6)<="00000000000000000000000000001000";
            RF(s7)<="00000000000000000000000000000011";
            init := false;
        end if;
      
      if rising_edge(clk) then
         if RegWrite = '1' then
            if to_integer(unsigned(WR)) /= 0 then
               RF(to_integer(unsigned(WR))) <= WD;
            end if;
         end if;


      end if;     
      
   end process;
            RD1 <= RF(s_RR1);
            RD2 <= RF(s_RR2);

end structural;
