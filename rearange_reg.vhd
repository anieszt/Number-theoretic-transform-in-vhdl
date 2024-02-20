library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.package1.all;

entity rearange_reg is

    port(
        rst : in std_logic;
        reg_state : in state;
        a, d : in L_array;
        q : out L_array;
        w : out S_array
    );

end rearange_reg;

architecture rtl of rearange_reg is

    signal qs : L_array;
    signal ws : S_array;

begin    

    process(rst,reg_state)
    begin
        if rst = '1' then

            qs <= (others => (others => '0'));
            ws <= (others => (others => '0'));

        else

            case reg_state is

                when idle =>

                    qs <= qs;
                    ws <= ws;


                when stage1 =>

                    qs(0) <= a(0);
                    qs(1) <= a(4);
                    qs(2) <= a(2);
                    qs(3) <= a(6);
                    qs(4) <= a(1);
                    qs(5) <= a(5);
                    qs(6) <= a(3);
                    qs(7) <= a(7);

                    ws(0) <= wc0;
                    ws(1) <= wc0;
                    ws(2) <= wc0;
                    ws(3) <= wc0;
            
                when stage2 =>
                    --if bfu_ready ='1' then

                        qs(0) <= d(0);
                        qs(1) <= d(2);
                        qs(2) <= d(1);
                        qs(3) <= d(3);
                        qs(4) <= d(4);
                        qs(5) <= d(6);
                        qs(6) <= d(5);
                        qs(7) <= d(7);

                        ws(0) <= wc0;
                        ws(1) <= wc2;
                        ws(2) <= wc0;
                        ws(3) <= wc2;

                when stage3 =>

                        qs(0) <= d(0);
                        qs(1) <= d(4);
                        qs(2) <= d(2);
                        qs(3) <= d(6); 
                        qs(4) <= d(1); 
                        qs(5) <= d(5);
                        qs(6) <= d(3);
                        qs(7) <= d(7);

                        ws(0) <= wc0;
                        ws(1) <= wc1;
                        ws(2) <= wc2;
                        ws(3) <= wc3;
                
                when clear1 =>

                        qs <= qs;

                        ws(0) <= wc0;
                        ws(1) <= wc2;
                        ws(2) <= wc0;
                        ws(3) <= wc2;
                
                when clear2 =>

                        qs <= qs;

                        ws(0) <= wc0;
                        ws(1) <= wc1;
                        ws(2) <= wc2;
                        ws(3) <= wc3;

                when clear3 =>

                        qs <= qs;

                        ws(0) <= wc0;
                        ws(1) <= wc0;
                        ws(2) <= wc0;
                        ws(3) <= wc0;
            
            end case;

        q <= qs;  
        w <= ws;

        end if;
    end process;

end architecture rtl;