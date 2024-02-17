library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.package1.all;

entity store_reg is
    generic(
        N : natural
    );
    port(
        rst, en: in std_logic;
        d0,d1,d2,d3,d4,d5,d6,d7 : in unsigned(N downto 0);
        q0,q1,q2,q3,q4,q5,q6,q7 : out unsigned(N downto 0)
    );
end store_reg;

architecture rtl of store_reg is

    signal qs0,qs1,qs2,qs3,qs4,qs5,qs6,qs7 : unsigned(N downto 0);
  
begin

    process(rst)
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
        
        else
            if en = '1' then

                qs0 <= d0;
                qs1 <= d1;
                qs2 <= d2;
                qs3 <= d3;
                qs4 <= d4;
                qs5 <= d5;
                qs6 <= d6;
                qs7 <= d7;
            else

                qs0 <= qs0;
                qs1 <= qs1;
                qs2 <= qs2;
                qs3 <= qs3;
                qs4 <= qs4;
                qs5 <= qs5;
                qs6 <= qs6;
                qs7 <= qs7;
            end if;
            
        end if;

    end process;

    q0 <= qs0;
    q1 <= qs1;
    q2 <= qs2;
    q3 <= qs3;
    q4 <= qs4;
    q5 <= qs5;
    q6 <= qs6;
    q7 <= qs7;

end architecture;