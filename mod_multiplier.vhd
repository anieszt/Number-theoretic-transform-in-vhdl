library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod_multiplier is

  generic( --(N=16,P=65537)
    N : natural;
    P : unsigned 
  );
  
  port(
    clk, rst : in std_logic;
    mult_a, mult_b : in unsigned(N downto 0); --N-1
    r : out unsigned(N downto 0)
    
    --debug
    --ii: out integer;
    --ss, ss0, ss1, sstate: out unsigned(2*N-1 downto 0)
    
   );
  
end entity mod_multiplier;

architecture arch of mod_multiplier is

  shared variable s, s0, s1, state : unsigned(2*N-1 downto 0) := (others => '0');
  shared variable pad: unsigned(N-3 downto 0) := (others => '0'); --N-2
  signal i : integer := 0;
  
begin --arch 

  process(clk, rst, i)
  
  begin --process
  
    if rst = '1' then --if1
      s := (others => '0');
      s1 := (others => '0');
      s0 := (others => '0');
      i <= 0; 
    elsif rising_edge(clk) then
      
      s0 := s + ((pad & mult_a(i)) * mult_b);
      s1 := p + s + ((pad & mult_a(i)) * mult_b); 
      i <= i + 1;
      if (s0(0) = '0') then --if2
      
        s := (pad(N-3 downto 0) &( '0' & s0(N+1 downto 1))); 
        
      else
      
        s := (pad(N-3 downto 0) &( '0' & s1(N+1 downto 1)));   
        
      end if; --if2
      
    end if; --if1

  end process;
  
  process(clk,rst,i)
  begin
  
    if(rst='1') then --if1
      state:=(others => '0');
      
    elsif(rising_edge(clk)) then
    
      if (i = N) then --if2
      
        if s<p then --if3
          state := s;
        else
          state := s - (pad & p);
        end if; --if3
        
      end if; --if2
      
    end if; --if1
    
  end process;
  
  r <=  p - ('0' & state(N-1 downto 0));  
  
  --ss <=s;
  --ss1 <=s1;
  --ss0<=s0;
  --sstate <= state;
  --ii<= i;
end architecture arch;