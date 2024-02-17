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
		bfu_ready, bbfu_rst : out std_logic;
		--debug
		--ii1, ii2, ii3, ii4 : out natural;
		--ww0,ww1,ww2,ww3 : out unsigned(N downto 0);
		vv0,vv1,vv2,vv3,vv4,vv5,vv6,vv7 : out unsigned(N downto 0);
		uu10,uu11,uu12,uu13,uu14,uu15,uu16,uu17 : out unsigned(N downto 0)
    );

end NTT;

architecture rtl of NTT is
    
    shared variable v0,v1,v2,v3,v4,v5,v6,v7 : unsigned(N downto 0);--v : L_array;
    shared variable u0,u1,u2,u3,u4,u5,u6,u7 : unsigned(N downto 0);--u : L_array;
    shared variable u10,u11,u12,u13,u14,u15,u16,u17 : unsigned(N downto 0);--u : L_array;
    shared variable w0,w1,w2,w3 : unsigned(N downto 0);--w : S_array;
	shared variable bfu_readystate, bfu_rststate, store_enstate : std_logic;
	signal state1 : state;

begin

	
	--c_stage <= state1;
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

	--reg
	rearange_reg_inst: entity work.rearange_reg
	generic map (
	  N => N
	)
	port map (
	  --clk       => clk,
	  rst       => rst,
	  bfu_ready => bfu_readystate,
	  reg_state => state1,

	  a0        => a0,
	  a1        => a1,
	  a2        => a2,
	  a3        => a3,
	  a4        => a4,
	  a5        => a5,
	  a6        => a6,
	  a7        => a7,

	  d0        => u10,
	  d1        => u11,
	  d2        => u12,
	  d3        => u13,
	  d4        => u14,
	  d5        => u15,
	  d6        => u16,
	  d7        => u17,

	  q0        => v0,
	  q1        => v1,
	  q2        => v2,
	  q3        => v3,
	  q4        => v4,
	  q5        => v5,
	  q6        => v6,
	  q7        => v7,

	  w0        => w0,
	  w1        => w1,
	  w2        => w2,
	  w3        => w3
	);

	store_reg_inst: entity work.store_reg
	generic map (
	  N => N
	)
	port map (
	  rst => rst,
	  en  => store_enstate,

	  d0  => u0,
	  d1  => u1,
	  d2  => u2,
	  d3  => u3,
	  d4  => u4,
	  d5  => u5,
	  d6  => u6,
	  d7  => u7,

	  q0  => u10,
	  q1  => u11,
	  q2  => u12,
	  q3  => u13,
	  q4  => u14,
	  q5  => u15,
	  q6  => u16,
	  q7  => u17
	);


    --bfublock
    
	bfu_block_4_inst: entity work.bfu_block_4
	generic map (
	  N => N,
	  P => P
	)
	port map (
	  clk => clk,
	  rst => bfu_rststate,
	  bfu_ready=> bfu_readystate,

	--   ii1 => ii1,
	--   ii2 => ii2,
	--   ii3 => ii3,
	--   ii4 => ii4,

	  v0  => v0,
	  v1  => v1,
	  v2  => v2,
	  v3  => v3,
	  v4  => v4,
	  v5  => v5,
	  v6  => v6,
	  v7  => v7,

	  w0  => w0,
	  w1  => w1,
	  w2  => w2,
	  w3  => w3,
	  
	  u0  => u0,
	  u1  => u1, 
	  u2  => u2,
	  u3  => u3,
	  u4  => u4,
	  u5  => u5,
	  u6  => u6,
	  u7  => u7
	);

	--O <= v;
	o0 <= u10;
    o1 <= u12;
    o2 <= u14;
    o3 <= u16;
    o4 <= u11;
    o5 <= u13;
    o6 <= u15;
    o7 <= u17;
	--ww <= w
	-- ww0 <= w0;
    -- ww1 <= w1;
    -- ww2 <= w2;
    -- ww3 <= w3;
	--uu <= u
	vv0 <= v0;
    vv1 <= v1;
    vv2 <= v2;
    vv3 <= v3;
    vv4 <= v4;
    vv5 <= v5;
    vv6 <= v6;
    vv7 <= v7;

	uu10 <= u0;
    uu11 <= u1;
    uu12 <= u2;
    uu13 <= u3;
    uu14 <= u4;
    uu15 <= u5;
    uu16 <= u6;
    uu17 <= u7;

	bfu_ready <= bfu_readystate;
	bbfu_rst <= bfu_rststate;

end architecture rtl;
