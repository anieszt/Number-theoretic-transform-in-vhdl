library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bfu_block_4 is

    generic(
		N : natural;
		P : unsigned
	);
	
	port(
		clk, rst : in std_logic;
		v0,v1,v2,v3,v4,v5,v6,v7 : in unsigned(N downto 0);
		w0, w1, w2, w3 : in unsigned(N downto 0);
		u0,u1,u2,u3,u4,u5,u6,u7 : out unsigned(N downto 0);
		bfu_ready : out std_logic
		
		--ii1, ii2, ii3, ii4 : out natural
	);

end bfu_block_4;

architecture rtl of bfu_block_4 is
	signal ready :  std_logic_vector(3 downto 0);
begin
	
	mod_bfu0: entity work.mod_bfu
        generic map(
			N => N,
			P => P
		)
		port map(
			clk => clk,
			rst => rst,
			a => v0,
			b => v1,
			w => w0,
			rA_bfu => u0,
			--ii => ii1,
			ready => ready(0),
			rB_bfu => u1
		);

    mod_bfu1: entity work.mod_bfu
        generic map(
			N => N,
			P => P
		)
		port map(
			clk => clk,
			rst => rst,
			a => v2,
			b => v3,
			w => w1,
			rA_bfu => u2,
			--ii => ii2,
			ready => ready(1),
			rB_bfu => u3
		);

    mod_bfu2: entity work.mod_bfu
        generic map(
			N => N,
			P => P
		)
		port map(
			clk => clk,
			rst => rst,
			a => v4,
			b => v5,
			w => w2,
			rA_bfu => u4,
			--ii => ii3,
			ready => ready(2),
			rB_bfu => u5
		);

    mod_bfu3: entity work.mod_bfu
        generic map(
			N => N,
			P => P
		)
		port map(
			clk => clk,
			rst => rst,
			a => v6,
			b => v7,
			w => w3,
			rA_bfu => u6,
			--ii => ii4,
			ready => ready(3),
			rB_bfu => u7
		);


		bfu_ready <= ready(0) and ready(1) and ready(2) and ready(3);
	
end architecture rtl;