----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2026 12:48:10
-- Design Name: 
-- Module Name: CLA - Behavioral
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
-- elements of the CLA tree
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GP is
    Port (
        G: in std_logic_vector(1 downto 0);
        P: in std_logic_vector(1 downto 0);
        cin: in std_logic :='0';
        G_o: out std_logic;
        P_o: out std_logic;
        cout: out std_logic
    );
end GP;

architecture behavior of GP is
    signal g1,p1: std_logic;
begin
    g1<=(G(1) or (G(0) and P(1)));
    p1<=P(0) and P(1);
    G_o<=g1;
    P_o<=p1;
    cout<=(g1 or (p1 and cin));
end behavior;

----------------------------------------------------------------------------------
-- main adder module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity CLA is
  Port ( 
        a: in std_logic_vector(7 downto 0);
        b: in std_logic_vector(7 downto 0);
        cin: in std_logic;
        sum: out std_logic_vector(7 downto 0);
        cout: out std_logic
  );
end CLA;

architecture Behavioral of CLA is
    signal gen_var,prop_var: std_logic_vector (7 downto 0);
    type arr is array(0 to 6) of std_logic_vector (1 downto 0); 
    signal g,p: arr :=(others=>(others=>'0'));
    signal ci,co,g_o,p_o: std_logic_vector(6 downto 0);
    signal ci_rc: std_logic_vector(3 downto 0);
begin
    --instantiation..
    -- element wise gen and prop
    rep_var: for i in a'range generate
        gen_var(i)<=a(i) and b(i);
        prop_var(i)<= a(i) xor b(i);
    end generate rep_var;
    
    -- instances of GP 
    rep_ins: for i in 0 to 6 generate
        ins: entity work.GP port map(G=>g(i),P=>p(i),cin=>ci(i),cout=>co(i),G_o=>g_o(i),P_o=>p_o(i));
    end generate rep_ins;
    
    -- ripple carry adders
    rep_insrc: for i in 0 to 3 generate
        ins1: entity work.adder_module port map(cin=>ci_rc(i),a=>a(2*i+1 downto 2*i),b=>b(2*i+1 downto 2*i),sum=>sum(2*i+1 downto 2*i),cout=>open);
    end generate rep_insrc;   
    
    --connections..
    rep_insert: for i in 0 to 3 generate
        g(i)(0)<=(a(6-2*i) and b(6-2*i));g(i)(1)<=(a(7-2*i) and b(7-2*i));p(i)(0)<=(a(6-2*i) xor b(6-2*i));p(i)(1)<=(a(7-2*i) and b(7-2*i));
    end generate rep_insert; 
    
    g(4)(1)<=g_o(0);g(4)(0)<=g_o(1);p(4)(1)<=p_o(0);p(4)(0)<=p_o(1);
    g(5)(1)<=g_o(2);g(5)(0)<=g_o(3);p(5)(1)<=p_o(2);p(5)(0)<=p_o(3);
    g(6)(1)<=g_o(4);g(6)(0)<=g_o(5);p(6)(1)<=p_o(4);p(6)(0)<=p_o(5);
    
    ci_rc(0)<=cin;ci_rc(1)<=co(3);ci_rc(2)<=co(5);ci_rc(3)<=co(1);
    ci(1)<=co(5);
    ci(3)<=cin;ci(5)<=cin;ci(6)<=cin;
    cout<=co(6);
end Behavioral;
