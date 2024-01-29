library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package package1 is

    constant N : natural := 16; --input (coef) size 
    constant I : natural := 4; --half number of inputs (coefs)
    constant P : unsigned := "10000000000000001"; --prime

    constant w0 : unsigned := "00000000000010000";
    constant w1 : unsigned := "00000000100000000";
    constant w2 : unsigned := "00010000000000000";
    constant w3 : unsigned := "10000000000000000";

    type L_array is array (0 to 2*I-1) of unsigned(N downto 0); --long array 8 elements
    type S_array is array (0 to I-1) of unsigned(N downto 0); --short array 4 elements

end package;