library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package package1 is
    
    --ntt parameters
    constant N : natural := 16; --input (coef) size 
    constant I : natural := 4; --half number of inputs (coefs)
    constant P : unsigned := "10000000000000001"; --prime

    --twiddle factors
    constant wc0 : unsigned := "00000000000000001";--1
    constant wc1 : unsigned := "00000000000010000";--16
    constant wc2 : unsigned := "00000000100000000";--256
    constant wc3 : unsigned := "00001000000000000";--4096

    --array types
    type L_array is array (0 to 2*I-1) of unsigned(N downto 0); --long array 8 elements
    type S_array is array (0 to I-1) of unsigned(N downto 0); --short array 4 elements

    -- type state is (idle, stage1, store1, clear1, stage2, store2, clear2,
    --                  stage3, store3, clear3);
    type state is (idle, stage1, clear1,  stage2, clear2,
    stage3, clear3);

end package;