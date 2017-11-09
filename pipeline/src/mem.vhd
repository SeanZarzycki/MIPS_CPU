library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mem is
    port (
        mmem : in std_logic_vector(31 downto 0);
        memwrite, memread : in std_logic;
        r : out std_logic;
        bmem_in : in std_logic_vector(31 downto 0);
        bmem_out : out std_logic_vector(31 downto 0)

    );
end mem;


architecture beh of mem is

    component DataMemory
        generic(n:natural := 8;
                l:natural := 8);

        port (
            WriteData: in std_logic_vector(31 downto 0);
            Address: in std_logic_vector(31 downto 0);
            Clk, MemRead, MemWrite: in std_logic;
            ReadData: out std_logic_vector(31 downto 0));
    end component;
    
    component AND2
        port(x,y:in std_logic;z:out std_logic);
    end component;

    component MUX32
    port(x,y : in std_logic_vector (31 downto 0);
         sel : in std_logic;
         z	 : out std_logic_vector(31 downto 0));
    end component;

    begin

        BRANCH_AND : AND2 port map(x => Branch, y => Zero, z => R);
        
        DATA_MEM : DataMemory port map(
            writedata => D, address => G, clk => clk, 
            memread => MemRead, memwrite => MemWrite, readdata => H);       

        M_DATA_MEM : MUX32 port map(x => G, y => H, sel => MemtoReg, z => J);

        -- M_L_M : MUX32 port map(x => L, y => M, sel => R, z => N);
        -- M_JUMP : MUX32 port map(x => N, y => Q, sel => Jump, z => P); 
end beh;