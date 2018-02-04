----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/19/2018 01:47:27 AM
-- Design Name: 
-- Module Name: ClassA1DDCT - arc
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
library work;
use work.mypack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_ClassA1DDCT is
--  port ();
end test_ClassA1DDCT;

architecture arc of test_ClassA1DDCT is

component ClassA1DDCT is
  port (clk: in std_logic;
        x0: in classA;
        x1: in classA;
        x2: in classA;
        x3: in classA;
        x4: in classA;
        x5: in classA;
        x6: in classA;
        x7: in classA;
        y0: out classA;
        y1: out classB;
        y2: out classC;
        y3: out classB;
        y4: out classA;
        y5: out classB;
        y6: out classC;
        y7: out classB);
end component;

component badFRSClassA is
    port (clk: in std_logic;
          y0: in classA;
          y1: in classB;
          y2: in classC;
          y3: in classB;
          y4: in classA;
          y5: in classB;
          y6: in classC;
          y7: in classB;
          ry0: out real;
          ry1: out real;
          ry2: out real; 
          ry3: out real;
          ry4: out real; 
          ry5: out real; 
          ry6: out real; 
          ry7: out real);
end component;

signal clk: std_logic;
signal x0, x1, x2, x3, x4, x5, x6, x7: classA;
signal y0, y4: classA;
signal y1, y3, y5, y7: classB;
signal y2, y6: classC;
signal ry0, ry1, ry2, ry3, ry4, ry5, ry6, ry7: real:= 0.0;
constant clk_period: time:= 20 ns;

begin

uut:ClassA1DDCT
port map(clk => clk,
        x0 => x0,
        x1 => x1,
        x2 => x2,
        x3 => x3,
        x4 => x4,
        x5 => x5,
        x6 => x6,
        x7 => x7,
        y0 => y0,
        y1 => y1,
        y2 => y2,
        y3 => y3,
        y4 => y4,
        y5 => y5,
        y6 => y6,
        y7 => y7);

badFRS: badFRSClassA
port map(clk => clk,
          y0 => y0,
          y1 => y1,
          y2 => y2,
          y3 => y3,
          y4 => y4,
          y5 => y5,
          y6 => y6,
          y7 => y7,
          ry0 => ry0,
          ry1 => ry1,
          ry2 => ry2,
          ry3 => ry3,
          ry4 => ry4,
          ry5 => ry5,
          ry6 => ry6,
          ry7 => ry7);

stim: process
begin
    x0 <= "11111110"; 
    x1 <= "11101110";
    x2 <= "00000010";                            
    x3 <= "00110000";
    x4 <= "00001000";
    x5 <= "00011110";
    x6 <= "00000010";                            
    x7 <= "11100010"; 
    wait for 10*clk_period;
    
    x0 <= "00000110"; 
    x1 <= "00100110";
    x2 <= "11111010";                            
    x3 <= "11101000";
    x4 <= "11111000";
    x5 <= "11101110";
    x6 <= "11111110";                            
    x7 <= "00010010";   
    wait for 10*clk_period;
end process;


clkp: process
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;
    
end arc;
