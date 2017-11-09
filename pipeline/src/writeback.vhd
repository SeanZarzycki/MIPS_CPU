library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity writeback is
port (
    hwb, gwb : in std_logic_vector(31 downto 0);
    memtoreg : in std_logic;
    j : out std_logic_vector(31 downto 0)
);
end writeback;

architecture beh of writeback is
    
    
    -- Components --
    component MUX32
    port(x,y : in std_logic_vector (31 downto 0);
         sel : in std_logic;
         z	 : out std_logic_vector(31 downto 0));
    end component;

    begin

    mux_0 : MUX32 port map (x => hwb, y => gwb, sel => memtoreg, z => j);

end beh;