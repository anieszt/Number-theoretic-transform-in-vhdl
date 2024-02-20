library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.package1.all;


entity control is 

    port(
        
        up_ctrl : in std_logic;
        clk, rst, bfu_ready : in std_logic;
        bfu_rst, store_en : out std_logic;
        c_stage : out state;

        --debug
        state_stage : out natural

    );

end control;

architecture rtl of control is

    signal state_reg : state;
    signal state_nxt : state;
    
begin

    process(clk, rst)
    begin
        if rst='1' then
            state_reg <= idle;
        elsif (clk'event and clk = '1') then --elsif *time for each stage
            state_reg <= state_nxt;
           
        end if;
    end process;

    process(rst,state_reg)
    begin      
        case state_reg is

            when idle => 
                state_stage <= 0;
                bfu_rst <='1';
                store_en <='0';
                if up_ctrl = '1' then
                    state_nxt <= stage1;
                else
                    state_nxt <= idle;
                end if;

            when stage1 => 

                state_stage <= 1;

                if bfu_ready ='1' then    
                    state_nxt <= clear1;
                    store_en <= '1';
                    bfu_rst <= '0';
                else 
                    state_nxt <= state_reg;
                    store_en <= '0';
                    bfu_rst <= '0';
                end if;

            when stage2 => 
                state_stage <= 2;

                if bfu_ready ='1' then    
                    state_nxt <= clear2;
                    store_en <= '1';
                    bfu_rst <= '0';
                else 
                    state_nxt <= state_reg;
                    store_en <= '0';
                    bfu_rst <= '0';
                end if;

            when stage3 =>
                state_stage <= 3;

                if bfu_ready ='1' then    
                    state_nxt <= clear3;
                    store_en <= '1';
                    bfu_rst <= '0';
                else 
                    state_nxt <= state_reg;
                    store_en <= '0';
                    bfu_rst <= '0';
                end if;


            when clear1 => 
                state_stage <= 11;

                state_nxt <= stage2;
                store_en <= '0';
                bfu_rst <= '1';

            when clear2 => 
                state_stage <= 12;

                state_nxt <= stage3;
                store_en <= '0';
                bfu_rst <= '1';

            when clear3 =>
                state_stage <= 13;

                state_nxt <= idle;
                store_en <= '0';
                bfu_rst <= '1';

        end case;                   
    end process;

    c_stage <= state_nxt;

    
end architecture rtl;
