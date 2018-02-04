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

entity ClassA1DDCT is
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
end ClassA1DDCT;

architecture arc of ClassA1DDCT is

signal A0, A1, A2, A3, A4, A5, A6, A7: classA := "00000000";
signal B0, B1, B2, B3, C0, C1, C2, C3: classA := "00000000";
signal D0, D1, D2, D3: classA := "00000000";

signal O0, O4: classA := "00000000";
signal O1, O3, O5, O7: classB := ("00000000", "00000000", "00000000", "00000000");
signal O2, O6: classC := ("00000000", "00000000");

begin

y0 <= O0;
y1 <= O1;
y2 <= O2;
y3 <= O3;
y4 <= O4;
y5 <= O5;
y6 <= O6;
y7 <= O7;

m: process(clk)
begin
    if(rising_edge(clk)) then
    
        O0 <= shift_left(C0, 1);
        O1 <= (-D3, D2, -D1, D0);
        O2 <= (C2, -C3);
        O3 <= (-D1, D3, D0, D2);
        O4 <= shift_left(C1,1);
        O5 <= (D2, -D0, D3, D1);
        O6 <= (-C3, -C2);
        O7 <= (-D0, -D1, -D2, -D3);

        D0 <= -A5+A6;
        D1 <= A4-A7;
        D2 <= A4+A7;
        D3 <= -A5-A6;
    
        C0 <= B0+B1;
        C1 <= B0-B1;
        C2 <= B2+B3;
        C3 <= B2-B3;
        
        B0 <= A0+A3;
        B1 <= A1+A2;
        B2 <= A1-A2;
        B3 <= A0-A3;
        
        A0 <= x0+x7; 
        A1 <= x1+x6; 
        A2 <= x2+x5; 
        A3 <= x3+x4; 
        A4 <= x3-x4; 
        A5 <= x2-x5;  
        A6 <= x1-x6; 
        A7 <= x0-x7; 
        
    end if;
end process;

end arc;
