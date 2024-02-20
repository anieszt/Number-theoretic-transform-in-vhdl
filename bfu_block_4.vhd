library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.package1.all;

entity bfu_block_4 is

    generic(
		N : natural;
		P : unsigned
	);
	
	port(
		clk, rst : in std_logic;
		-- v0,v1,v2,v3,v4,v5,v6,v7 : in unsigned(N downto 0);
		-- w0, w1, w2, w3 : in unsigned(N downto 0);
		-- u0,u1,u2,u3,u4,u5,u6,u7 : out unsigned(N downto 0);

		v : in L_array;
		w : in S_array;
		u : out L_array;

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
			a => v(0),
			b => v(1),
			w => w(0),
			rA_bfu => u(0),
			--ii => ii1,
			ready => ready(0),
			rB_bfu => u(1)
		);

    mod_bfu1: entity work.mod_bfu
        generic map(
			N => N,
			P => P
		)
		port map(
			clk => clk,
			rst => rst,
			a => v(2),
			b => v(3),
			w => w(1),
			rA_bfu => u(2),
			--ii => ii2,
			ready => ready(1),
			rB_bfu => u(3)
		);

    mod_bfu2: entity work.mod_bfu
        generic map(
			N => N,
			P => P
		)
		port map(
			clk => clk,
			rst => rst,
			a => v(4),
			b => v(5),
			w => w(2),
			rA_bfu => u(4),
			--ii => ii3,
			ready => ready(2),
			rB_bfu => u(5)
		);

    mod_bfu3: entity work.mod_bfu
        generic map(
			N => N,
			P => P
		)
		port map(
			clk => clk,
			rst => rst,
			a => v(6),
			b => v(7),
			w => w(3),
			rA_bfu => u(6),
			--ii => ii4,
			ready => ready(3),
			rB_bfu => u(7)
		);

		bfu_ready <= ready(0) and ready(1) and ready(2) and ready(3);
	
end architecture rtl;