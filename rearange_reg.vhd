library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.package1.all;

entity rearange_reg is
    generic(
        N : natural
    );
    port(
        rst, bfu_ready : in std_logic;
        reg_state : in state;
        a0,a1,a2,a3,a4,a5,a6,a7 : in unsigned(N downto 0);
        d0,d1,d2,d3,d4,d5,d6,d7 : in unsigned(N downto 0);
        q0,q1,q2,q3,q4,q5,q6,q7 : out unsigned(N downto 0);
        w0,w1,w2,w3 : out unsigned(N downto 0)
    );
end rearange_reg;

architecture rtl of rearange_reg is

    signal qs0,qs1,qs2,qs3,qs4,qs5,qs6,qs7 : unsigned(N downto 0);
    signal ws0,ws1,ws2,ws3 : unsigned(N downto 0);

begin    

    process(rst,reg_state)
    begin
        if rst = '1' then

            qs0 <= (others => '0');
            qs1 <= (others => '0');
            qs2 <= (others => '0');
            qs3 <= (others => '0');
            qs4 <= (others => '0');
            qs5 <= (others => '0');
            qs6 <= (others => '0');
            qs7 <= (others => '0');

            ws0 <= (others => '0');
            ws1 <= (others => '0');
            ws2 <= (others => '0');
            ws3 <= (others => '0');

        else --elsif clk'event and clk = '1' then

            case reg_state is

                when idle =>

                    qs0 <= qs0;
                    qs1 <= qs1;
                    qs2 <= qs2;
                    qs3 <= qs3;
                    qs4 <= qs4;
                    qs5 <= qs5;
                    qs6 <= qs6;
                    qs7 <= qs7;

                    ws0 <= ws0;
                    ws1 <= ws0;
                    ws2 <= ws0;
                    ws3 <= ws0;

                when stage1 =>

                    qs0 <= a0;
                    qs1 <= a4;
                    qs2 <= a2;
                    qs3 <= a6;
                    qs4 <= a1;
                    qs5 <= a5;
                    qs6 <= a3;
                    qs7 <= a7;

                    ws0 <= wc0;
                    ws1 <= wc0;
                    ws2 <= wc0;
                    ws3 <= wc0;
            
                when stage2 =>
                    --if bfu_ready ='1' then

                        qs0 <= d0;
                        qs1 <= d2;
                        qs2 <= d1;
                        qs3 <= d3;
                        qs4 <= d4;
                        qs5 <= d6;
                        qs6 <= d5;
                        qs7 <= d7;

                        ws0 <= wc0;
                        ws1 <= wc2;
                        ws2 <= wc0;
                        ws3 <= wc2;
            
                    -- else

                    --     qs0 <= qs0;
                    --     qs1 <= qs1;
                    --     qs2 <= qs2;
                    --     qs3 <= qs3;
                    --     qs4 <= qs4;
                    --     qs5 <= qs5;
                    --     qs6 <= qs6;
                    --     qs7 <= qs7;
                           
                    --     ws0 <= ws0;
                    --     ws1 <= ws1;
                    --     ws2 <= ws2;
                    --     ws3 <= ws3;
                    
                    -- end if;

                when stage3 =>
                    -- if bfu_ready ='1' then
                        qs0 <= d0;
                        qs1 <= d4;
                        qs2 <= d2;
                        qs3 <= d6; 
                        qs4 <= d1; 
                        qs5 <= d5;
                        qs6 <= d3;
                        qs7 <= d7;

                        ws0 <= wc0;
                        ws1 <= wc1;
                        ws2 <= wc2;
                        ws3 <= wc3;
                
                when clear1 =>

                        qs0 <= qs0;
                        qs1 <= qs1;
                        qs2 <= qs2;
                        qs3 <= qs3;
                        qs4 <= qs4;
                        qs5 <= qs5;
                        qs6 <= qs6;
                        qs7 <= qs7;

                        ws0 <= wc0;
                        ws1 <= wc2;
                        ws2 <= wc0;
                        ws3 <= wc2;
                
                when clear2 =>

                        qs0 <= qs0;
                        qs1 <= qs1;
                        qs2 <= qs2;
                        qs3 <= qs3;
                        qs4 <= qs4;
                        qs5 <= qs5;
                        qs6 <= qs6;
                        qs7 <= qs7;

                        ws0 <= wc0;
                        ws1 <= wc1;
                        ws2 <= wc2;
                        ws3 <= wc3;

                when clear3 =>
                    
                        qs0 <= qs0;
                        qs1 <= qs1;
                        qs2 <= qs2;
                        qs3 <= qs3;
                        qs4 <= qs4;
                        qs5 <= qs5;
                        qs6 <= qs6;
                        qs7 <= qs7;
    
                        ws0 <= wc0;
                        ws1 <= wc0;
                        ws2 <= wc0;
                        ws3 <= wc0;


                        
                    --     lse
    
                    --     qs0 <= qs0;
                    --     qs1 <= qs1;
                    --     qs2 <= qs2;
                    --     qs3 <= qs3;
                    --     qs4 <= qs4;
                    --     qs5 <= qs5;
                    --     qs6 <= qs6;
                    --     qs7 <= qs7;
    
                    --     ws0 <= ws0;
                    --     ws1 <= ws1;
                    --     ws2 <= ws2;
                    --     ws3 <= ws3;
                        
                    -- end if;
                
            
            end case;

        q0 <= qs0;
        q1 <= qs1;
        q2 <= qs2;
        q3 <= qs3;
        q4 <= qs4;
        q5 <= qs5;
        q6 <= qs6;
        q7 <= qs7;
            
        w0 <= ws0;
        w1 <= ws1;
        w2 <= ws2;
        w3 <= ws3;

        end if;
    end process;

end architecture rtl;