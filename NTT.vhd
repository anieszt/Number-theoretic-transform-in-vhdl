library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.package1.all;

entity NTT is
    port(
	up_ctrl : in std_logic;
        clk, rst : in std_logic;
        a0,a1,a2,a3,a4,a5,a6,a7 : in unsigned(N downto 0);--A : in L_array;
        o0,o1,o2,o3,o4,o5,o6,o7 : out unsigned(N downto 0);
	statestage : out natural;
	bfu_ready, bbfu_rst : out std_logic
    );
end NTT;

architecture rtl of NTT is
	signal u, u1, v : L_array;
    	signal w : S_array;
	signal bfu_readystate, bfu_rststate, store_enstate : std_logic;
	signal state1 : state;
begin
control_inst: entity work.control
port map (
	  up_ctrl => up_ctrl,
	  clk     => clk,
	  rst     => rst,
	  bfu_rst => bfu_rststate,
	  store_en => store_enstate,
	  bfu_ready => bfu_readystate,
   	  c_stage   => state1,
	  state_stage => statestage	
	);
	
rearange_reg_inst: entity work.rearange_reg
	port map (
	  rst       => rst,
	  --bfu_ready => bfu_readystate,
	  reg_state => state1,
	  a(0)        => a0,
	  a(1)        => a1,
	  a(2)        => a2,
	  a(3)        => a3,
	  a(4)        => a4,
	  a(5)        => a5,
	  a(6)        => a6,
	  a(7)        => a7,
	  d	      => u1,
	  q 	      => v,
	  w           => w
	);

store_reg_inst: entity work.store_reg
	port map (
	  rst => rst,
	  en  => store_enstate,
	  d => u,
	  q => u1
	);
	
bfu_block_4_inst: entity work.bfu_block_4
	generic map (		
	  N => N,
	  P => P
	)
	port map (
	  clk => clk,
	  rst => bfu_rststate,
	  bfu_ready=> bfu_readystate,
	  v  => v,
	  w  => w,
	  u  => u
	);

o0 <= u1(0);
o1 <= u1(2);
o2 <= u1(4);
o3 <= u1(6);
o4 <= u1(1);
o5 <= u1(3);
o6 <= u1(5);
o7 <= u1(7);

bfu_ready <= bfu_readystate;
bbfu_rst <= bfu_rststate;

end architecture rtl;
