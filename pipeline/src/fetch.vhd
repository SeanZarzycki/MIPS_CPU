library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fetch is

    port (
        clk          : in std_logic;
        AddressIn   : in std_logic_vector(31 downto 0);
        instruction  : out std_logic_vector(31 downto 0);
        pc_increment : out std_logic_vector(31 downto 0)
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

    -- Signals --
    signal sig_AddressOut : std_logic_vector(31 downto 0);


    begin


        MAIN_PC : PC port map(clk => clk, AddressIn => p, AddressOut => a);

        INSTR_MEM : instmemory port map(address => a, readdata => Instruction);
        PC_ACC : ALU port map(
            a => A, b => PC_INCR, 
            oper => "0010", result => L, 
            zero => open, overflow => open);
        
end beh;