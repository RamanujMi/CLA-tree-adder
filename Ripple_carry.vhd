----------------------------------------------------------------------------------
-- Company: 
-- Engineer:
-- 
-- Create Date: 05.10.2026 15:20:38
-- Design Name: 
-- Module Name: adder_module - Behavioral
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

entity full_adder is
 Port ( 
        a : in std_logic;
        b : in std_logic;
        c: in std_logic;
        sum : out std_logic;
        cout : out std_logic
 );
end full_adder;

architecture Behavioral of full_adder is
    signal i1,a1,a2: std_logic;
begin
    i1<=(a xor b);
    sum<=(i1 xor c);
    a1<=(a and b);
    a2<=(i1 and c);
    cout<=(a1 or a2);
end Behavioral;
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity adder_module is
   Port(
        cin: in std_logic;
        a : in std_logic_vector (1 downto 0);
        b : in std_logic_vector (1 downto 0);
        sum : out std_logic_vector (1 downto 0);
        cout : out std_logic
    );
end adder_module;

architecture behaviour of adder_module is
    signal c1: std_logic;
begin
    ins1: entity work.full_adder port map(c=>cin,a=>a(0),b=>b(0),sum=>sum(0),cout=>c1);
    ins2: entity work.full_adder port map(c=>c1,a=>a(1),b=>b(1),sum=>sum(1),cout=>cout);
     
end behaviour;

----------------------------------------------------------------------------------


