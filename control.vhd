library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.package1.all;

entity control is 

    port(
        up_ctrl : in std_logic;
        clk, rst: in std_logic;
        V : out L_array;
        w_rom_read : out natural
    );

end control;

architecture rtl of control is

    type state is (idle, load, stage1, stage2, stage3);
    signal state_reg, state_nxt : state;
    signal c_stage : natural := 0;

    signal V_reg : L_array;
    signal V_nxt : L_array;

begin
    -- control path
    process(clk, rst)
    begin
        if rst='1' then
            state_reg <= idle;
        elsif rising_edge(clk) then --elsif *time for each stage*
            state_reg <= state_nxt;
        end if;
    end process;

    process(state_reg, rst)
    begin      
        case state_reg is
            when idle => 
                if up_ctrl = '1' then
                    state_nxt <= load;
                else
                    state_nxt <= idle;
                end if;
            when load => 
                state_nxt <= stage1;
            when stage1 => 
                state_nxt <= stage2;
            when stage2 => 
                state_nxt <= stage3;
            when stage3 =>
                state_nxt <= idle;
        end case;                   
    end process;

    --data path

    process(clk,rst)
    begin
        if rst = '1' then
        V_reg <= (others => '0');
        end if;
    end process;

    
end architecture rtl;
