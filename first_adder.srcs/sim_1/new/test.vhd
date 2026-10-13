----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2026 22:57:48
-- Design Name: 
-- Module Name: test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test is
end test;

architecture Behavioral of test is
    signal a,b: std_logic_vector(7 downto 0):=(others => '0');
    signal sum: std_logic_vector(7 downto 0);
    signal cout: std_logic;
    signal cin: std_logic;

begin
    uut: entity work.CLA
        port map(cin=>cin,a => a, b => b, sum => sum, cout => cout);
        
    process
    begin
        cin<='0';
        a<="10100011"; b<="11100010"; wait for 10ns;
        
        a<="11101010"; b<="11100011"; wait for 10ns;
    wait;
    end process;


end Behavioral;
