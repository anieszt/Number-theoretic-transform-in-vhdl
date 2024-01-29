library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.package1.all;

entity twiddle_factors_rom is

    generic(
        N : integer := 16 
    );

    port(
        clk : in std_logic;
        w_rom_read : in natural; --when wromread=? : w1,w2,w3,w4 <= ?,?,?,?
        w : out S_array
    );

end twiddle_factors_rom;