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
   constant s4 : integer := 20;
   constant s5 : integer := 21;

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
         RF(t0) <= std_logic_vector(to_unsigned(0, 32));
         RF(s4) <= std_logic_vector(to_unsigned(14, 32));
         RF(s5) <= std_logic_vector(to_unsigned(5, 32));      
         init := false;
      end if;
      
      if clk'event and clk='1' then
         if RegWrite = '1' then
            if s_WR /= 0 then
               RF(s_WR) <= WD;
            end if;
         end if;
            -- if s_WR = s_RR1 then
               -- RD1 <= WD;
            -- elsif s_WR = s_RR2 then
               -- RD2 <= WD;
            -- end if;

      end if;     
      
   end process;
            RD1 <= RF(s_RR1);
            RD2 <= RF(s_RR2);

end structural;
