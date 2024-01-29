library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.package1.all;

entity control is 

    port(
        up_ctrl : in std_logic;
        clk, rst: in std_logic;
        a : in L_array;
        u : in L_array;
        v : out L_array;
        w : out S_array
    );

end control;

architecture rtl of control is

    type state is (idle, stage1, stage2, stage3);
    signal state_reg, state_nxt : state;

    signal V_reg : L_array;
    signal V_nxt : L_array;

begin
    -- control path
    process(clk, rst)
    begin
        if rst='1' then
            state_reg <= idle;
        elsif (clk'event and clk = '1') then --elsif *time for each stage*
            state_reg <= state_nxt;
        end if;
    end process;

    process(state_reg, rst)
    begin      
        case state_reg is
            when idle => 
                if up_ctrl = '1' then
                    state_nxt <= stage1;
                else
                    state_nxt <= idle;
                end if;
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
            V_reg <= (others => (others => '0'));
        elsif (clk'event and clk = '1') then
            V_reg <= V_nxt;
        end if;
    end process;

    process(state_reg, V_reg)
    begin
        case state_reg is
            when idle => 
                V_nxt <= V_reg;
            when stage1 => 
                V_nxt(0) <= a(0);
                V_nxt(1) <= a(4);
                V_nxt(2) <= a(2);
                V_nxt(3) <= a(6);
                V_nxt(4) <= a(1);
                V_nxt(5) <= a(5);
                V_nxt(6) <= a(3);
                V_nxt(7) <= a(7);

                w <= (w0,w0,w0,w0);
            when stage2 => 
                V_nxt(0) <= u(0);
                V_nxt(1) <= u(2);
                V_nxt(2) <= u(1);
                V_nxt(3) <= u(3);
                V_nxt(4) <= u(4);
                V_nxt(5) <= u(6);
                V_nxt(6) <= u(5);
                V_nxt(7) <= u(7);

                w <= (w0,w2,w0,w2);
            when stage3 => 
                V_nxt(0) <= u(0);
                V_nxt(1) <= u(4);
                V_nxt(2) <= u(1);
                V_nxt(3) <= u(5);
                V_nxt(4) <= u(2);
                V_nxt(5) <= u(6);
                V_nxt(6) <= u(3);
                V_nxt(7) <= u(7);

                w <= (w0,w1,w2,w3);
        end case;
    end process;

    v <= V_reg;

    
end architecture rtl;
