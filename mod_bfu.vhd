library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mod_bfu is

	generic(
		N : natural;	
		P : unsigned
	);
	
	port(
		clk, rst : in std_logic;
		a, b, w : in unsigned(N downto 0);
		rA_bfu, rB_bfu : out unsigned(N downto 0)
	);
	
end mod_bfu;

architecture arch of mod_bfu is

	signal wb_state : unsigned(N downto 0) := (others => '0');
	
begin
	
	mod_multiplier: entity work.mod_multiplier
		generic map(
			N => N,
			P => P
		)
		port map(
			clk => clk,
			rst => rst,
			mult_a =>b,
			mult_b =>w,
			r => wb_state
		);
		
	mod_adder: entity work.mod_adder
		generic map(
			N => N,
			P => P
		)
		port map(
			clk => clk,
			rst => rst,
			adder_a => a,
			adder_b => wb_state,
			r => rA_bfu
		);
		
	mod_subtractor: entity work.mod_subtractor
		generic map(
			N => N,
			P => P
		)
		port map(
			clk => clk,
			rst => rst,
			subtr_a => a,
			subtr_b => wb_state,
			r => rB_bfu
		);
	
end arch;