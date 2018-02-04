----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2018 12:12:05 AM
-- Design Name: 
-- Module Name: frs_B11 - arc
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: This design implements the FRS for class B AI quantities
-- using the dyadic approximation method with 11-bits constants.
-- Latency: 6 clock cycles.
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

entity frs_B11 is
    port(clk : in std_logic;
        input: in classB;
        output: out classA);
end frs_B11;

architecture arc of frs_B11 is

signal t1, t2, t3, t4, t5, t6: signed(21 downto 0):=  to_signed(0,22);
signal t7, t8, t9, t10, t11, t12, f_dec: signed(21 downto 0):=  to_signed(0,22);
signal x1, x3, x5, x7: signed(21 downto 0):=  to_signed(0,22);
signal u1, u3, u5, u7, u7r: signed(21 downto 0):=  to_signed(0,22);
type ureg is array (natural range <>) of signed(21 downto 0);
signal t9reg: ureg(1 downto 0):= (to_signed(0, 22), to_signed(0, 22));


begin

--converting the input signal from 8-bit to 11-bit
x1(21 downto 14) <= input(0);
x3(21 downto 14) <= input(1);
x5(21 downto 14) <= input(2);
x7(21 downto 14) <= input(3);

u1 <= shift_right(x1,14);
u3 <= shift_right(x3,14);
u5 <= shift_right(x5,14);
u7 <= shift_right(x7,14);

--converting the output signal from 11-bit to 8-bit
output <= f_dec(7 downto 0);

m: process(clk)

begin
    if(rising_edge(clk)) then
        
        f_dec <= shift_right(shift_left(t9reg(1), 10)+t12,11);
        t12 <= shift_left(t11,4)+t10;
        t11 <= t3+shift_left(t8, 2);
        t10 <= -shift_left(t3,1)+t7;
        t9 <= -t2+shift_left(t6,2);
        t8 <= -t1+shift_left(t5,2);
        t7 <= t4-shift_left(t1,4);
        t6 <= u3+u1;
        t5 <= u5+shift_left(u7,2);
        t4 <= -u7+u1;
        t3 <= t2-shift_left(u7r, 4);
        t2 <= u3-shift_left(u5, 1);
        t1 <= u1-shift_left(u3,2);
        
        --updating internal registers
        t9reg(1) <= t9reg(0);
        t9reg(0) <= t9;
        u7r <= u7;
        
    end if;
end process;


end arc;
