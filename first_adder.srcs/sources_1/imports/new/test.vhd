library ieee;
use ieee.std_logic_1164.all;

entity adder_tb is
end adder_tb;

architecture sim of adder_tb is
  signal a, b : std_logic_vector(3 downto 0) := (others => '0');
  signal sum  : std_logic_vector(3 downto 0);
  signal cout : std_logic;
begin
  uut : entity work.adder_module
    port map (a => a, b => b, sum => sum, cout => cout);

  stim : process
  begin
    a <= "0011"; b <= "0101"; wait for 10 ns;  -- 3 + 5 = 8, cout = 0

    a <= "1111"; b <= "0001"; wait for 10 ns;  -- 15 + 1 = 16, sum = 0, cout = 1
  end process stim;
end sim;