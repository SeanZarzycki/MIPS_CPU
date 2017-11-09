library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fetch is

    port (
        clk          : in std_logic;
        lif, iif : out std_logic_vector(31 downto 0);
        pcsrc : in std_logic;
        mmem : in std_logic_vector(31 downto 0)
    );
end fetch;

architecture beh of fetch is
    
    -- Components --
    component InstMemory is
        port(
             Address           : in  std_logic_vector(31 downto 0);
             ReadData          : out std_logic_vector(31 downto 0));
    end component;

    component PC is
        port(clk,       : in  std_logic;
             AddressIn  : in  std_logic_vector(31 downto 0);
             AddressOut : out std_logic_vector(31 downto 0));
    end component;

    component MUX32
    port(x,y : in std_logic_vector (31 downto 0);
         sel : in std_logic;
         z	 : out std_logic_vector(31 downto 0));
    end component;

    -- Signals --
    signal sig_AddressOut : std_logic_vector(31 downto 0);
    signal sig_lif : std_logic_vector(31 downto 0);
    signal A : std_logic_vector(31 downto 0);
    signal p : std_logic_vector(31 downto 0);

    begin


        MAIN_PC : PC port map(clk => clk, AddressIn => p, AddressOut => a);

        INSTR_MEM : instmemory port map(address => a, readdata => iif);
        PC_ACC : ALU port map(
            a => A, b => 4, 
            oper => "0010", result => sig_lif, 
            zero => open, overflow => open);

        PC_SRC_MUX : MUX32 port map (
            x => mmem, y => sig_lif, sel => pcsrc, z => p); 
        );
        lif <= sig_lif;
        
end beh;