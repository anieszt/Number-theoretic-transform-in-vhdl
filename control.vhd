library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.package1.all;

entity control is 

    port(
        --hi_lvl_ctrl : in std logic
        clk, rst: in std_logic;
        V : out L_array;
        w_rom_read : out natural
    );

end control;

architecture rtl of control is

    type state is (idle, stage1, stage2, stage3);
    signal state_reg, state_nxt : state;
    signal current_stage : integer := 0;

    signal V_reg : L_array;
    signal V_nxt : L_array;

begin
    
    process(clk, rst)
    begin
        if rst='1' then
            state_reg <= idle;
        elsif rising_edge(clk) then
            state_reg <= state_nxt;
        end if;
    end process;

    --process(state_reg, rst)
    --begin
        
    
end architecture rtl;
