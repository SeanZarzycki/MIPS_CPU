library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity id_ex_reg is
    port (
        clk : in std_logic;
        lid, cid, did, eid : in std_logic_vector(31 downto 0);
        lex, cex, dex, eex : out std_logic_vector(31 downto 0);
        aluSrc_in, aluOp_in, regdst_in, branch_in, memread_in, memwrite_in, jump_in  : in std_logic;
        alusrc_out, aluop_out, regdst_out, branch_out, memread_out, memwrite_out, jump_out : out std_logic
    );
end id_ex_reg;

architecture beh of id_ex_reg is

begin
    process (clk)
    begin
        if rising_edge(clk) then
            lex <= lid;
            cex <= cid;
            dex <= did;
            eex <= eid;
            regdst_out <= regdst_in;
            branch_out <= branch_in;
            memread_out <= memread_in;
            memwrite_out <= memwrite_in;
            jump_out <= jump_in;
        end if;
end beh;