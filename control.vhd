library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.package1.all;


entity control is 

    port(
        up_ctrl : in std_logic;
        clk, rst, bfu_ready : in std_logic;
        bfu_rst, store_en : out std_logic;
        -- a0,a1,a2,a3,a4,a5,a6,a7 : in unsigned(N downto 0);--a : in L_array;
        -- u0,u1,u2,u3,u4,u5,u6,u7 : in unsigned(N downto 0);--u : in L_array;
        -- v0,v1,v2,v3,v4,v5,v6,v7 : out unsigned(N downto 0);--v : out L_array;
        -- w0,w1,w2,w3 : out unsigned(N downto 0);--w : out S_array;
        c_stage : out state;

        --debug
        state_stage : out natural

    );

end control;

architecture rtl of control is

    signal clk_seg : unsigned(5 downto 0);
    shared variable i : natural := 0;

    -- type state is (idle, stage1, stage2, stage3);
    signal state_reg : state;
    signal state_nxt : state;

    -- signal vreg0,vreg1,vreg2,vreg3,vreg4,vreg5,vreg6,vreg7 : unsigned(N downto 0);--V_reg : L_array;
    -- signal vnxt0,vnxt1,vnxt2,vnxt3,vnxt4,vnxt5,vnxt6,vnxt7 : unsigned(N downto 0);--V_nxt : L_array;

    
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

    --data path

    -- process(rst,clk_seg(0), bfu_ready)
    -- begin
    --     if rst = '1' then
    --         vreg0 <= (others => '0');
    --         vreg1 <= (others => '0'); --V_reg <= (others => (others => '0'));
    --         vreg2 <= (others => '0');
    --         vreg3 <= (others => '0');
    --         vreg4 <= (others => '0');
    --         vreg5 <= (others => '0');
    --         vreg6 <= (others => '0');
    --         vreg7 <= (others => '0');
    --     elsif (clk_seg(0)'event and clk_seg(0) = '1' and bfu_ready = '1') then
        
    --         --V_reg <= V_nxt;
    --         vreg0 <= vnxt0;
    --         vreg1 <= vnxt1;
    --         vreg2 <= vnxt2;
    --         vreg3 <= vnxt3;
    --         vreg4 <= vnxt4;
    --         vreg5 <= vnxt5;
    --         vreg6 <= vnxt6;
    --         vreg7 <= vnxt7;
    --     end if;
    -- end process;

    -- process(state_reg)
    -- begin
    --     case state_reg is
    --         when idle => 
    --             -- V_nxt := V_reg;
    --             vnxt0 <= vreg0;
    --             vnxt1 <= vreg1;
    --             vnxt2 <= vreg2;
    --             vnxt3 <= vreg3;
    --             vnxt4 <= vreg4; ---- PROBLEM IS HERE VREG CHANGES CONTINUOUSLYYYYY
    --             vnxt5 <= vreg5;
    --             vnxt6 <= vreg6;
    --             vnxt7 <= vreg7;
  
    --             w0 <= "00000000000000000";
    --             w1 <= "00000000000000000";
    --             w2 <= "00000000000000000";
    --             w3 <= "00000000000000000";
	-- 				 c_stage <= 0;
    --         when stage1 => 

    --             vnxt0 <= a0;
    --             vnxt1 <= a4;
    --             vnxt2 <= a2;
    --             vnxt3 <= a6;
    --             vnxt4 <= a1;
    --             vnxt5 <= a5;
    --             vnxt6 <= a3;
    --             vnxt7 <= a7;

    --             w0 <= wc0;
    --             w1 <= wc0;
    --             w2 <= wc0;
    --             w3 <= wc0;

    --             c_stage <= 1;
    --         when stage2 => 
                
    --             vnxt0 <= u0;
    --             vnxt1 <= u2;
    --             vnxt2 <= u1;
    --             vnxt3 <= u3;
    --             vnxt4 <= u4;
    --             vnxt5 <= u6;
    --             vnxt6 <= u5;
    --             vnxt7 <= u7;

    --             w0 <= wc0;
    --             w1 <= wc2;
    --             w2 <= wc0;
    --             w3 <= wc2;
                
    --             c_stage <= 2;
    --         when stage3 => 

    --             vnxt0 <= u0;
    --             vnxt1 <= u4;
    --             vnxt2 <= u1;
    --             vnxt3 <= u5;
    --             vnxt4 <= u2;
    --             vnxt5 <= u6;
    --             vnxt6 <= u3;
    --             vnxt7 <= u7;

    --             w0 <= wc0;
    --             w1 <= wc1;
    --             w2 <= wc2;
    --             w3 <= wc3;
    --             c_stage <= 3;
    --     end case;
    -- end process;

    -- v0 <= vreg0;
    -- v1 <= vreg1;
    -- v2 <= vreg2;
    -- v3 <= vreg3;
    -- v4 <= vreg4;
    -- v5 <= vreg5;
    -- v6 <= vreg6;
    -- v7 <= vreg7;

    
end architecture rtl;
