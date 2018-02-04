----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/20/2018 05:42:49 AM
-- Design Name: 
-- Module Name: badFRSClassA - arc
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

entity badFRSClassA is
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
end badFRSClassA;

architecture arc of badFRSClassA is

signal r0, r1, r2, r3, r4, r5, r6, r7: real :=0.0;

begin

ry0 <= r0;
ry1 <= r1;
ry2 <= r2;
ry3 <= r3;
ry4 <= r4;
ry5 <= r5;
ry6 <= r6;
ry7 <= r7;

m: process(clk)
begin
    if(rising_edge(clk)) then
        r0 <= real(to_integer(y0))/2;
        r4 <= real(to_integer(y4))/2;
        
        r1 <= real(to_integer(y1(0)))*0.9808+real(to_integer(y1(1)))*0.8315+real(to_integer(y1(2)))*0.5556+real(to_integer(y1(3)))*0.1951;
        r3 <= real(to_integer(y3(0)))*0.9808+real(to_integer(y3(1)))*0.8315+real(to_integer(y3(2)))*0.5556+real(to_integer(y3(3)))*0.1951;
        r5 <= real(to_integer(y5(0)))*0.9808+real(to_integer(y5(1)))*0.8315+real(to_integer(y5(2)))*0.5556+real(to_integer(y5(3)))*0.1951;
        r7 <= real(to_integer(y7(0)))*0.9808+real(to_integer(y7(1)))*0.8315+real(to_integer(y7(2)))*0.5556+real(to_integer(y7(3)))*0.1951;
        
        r2 <= real(to_integer(y2(0)))*0.9239+real(to_integer(y2(1)))*0.3827;
        r6 <= real(to_integer(y6(0)))*0.9239+real(to_integer(y6(1)))*0.3827;
    end if;
end process;

end arc;
