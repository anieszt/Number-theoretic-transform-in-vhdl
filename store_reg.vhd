library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.package1.all;

entity store_reg is
    port(
        rst, en: in std_logic;
        d : in L_array;
        q : out L_array

    );
end store_reg;

architecture rtl of store_reg is

    signal qs : L_array;
  
begin

    process(rst)
    begin       

        if rst = '1' then

            qs <= (others => (others => '0'));  
                 
        else

            if en = '1' then
                qs <= d;
            else
                qs <= qs;             
            end if;      

        end if;

    end process;

    q <= qs;

end architecture;