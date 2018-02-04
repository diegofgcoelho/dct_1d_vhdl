----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2018 12:12:05 AM
-- Design Name: 
-- Module Name: frs_D11 - arc
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: This design implements the FRS for class D AI quantities
-- using the dyadic approximation method with 11-bits constants.
-- Latency: 7 clock cycles.
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

entity frs_D11 is
    port(clk : in std_logic;
    input: in classD;
    output: out classA);
end frs_D11;

architecture arc of frs_D11 is

signal t2, t4, t5, t6, t7, f_dec: signed(21 downto 0):=  to_signed(0,22);
signal x0, x2, x4, x6: signed(21 downto 0):=  to_signed(0,22);
signal u0, u2, u4, u6: signed(21 downto 0):=  to_signed(0,22);
type ureg is array (natural range <>) of signed(21 downto 0);
signal u2reg, u4reg: ureg(1 downto 0) := (to_signed(0,22), to_signed(0,22));
signal u0reg: ureg(4 downto 0) := (to_signed(0,22), to_signed(0,22), to_signed(0,22), to_signed(0,22), to_signed(0,22));
signal u6reg: ureg(3 downto 0) := (to_signed(0,22), to_signed(0,22), to_signed(0,22), to_signed(0,22));
signal t1reg, t3reg: ureg(2 downto 0) := (to_signed(0,22), to_signed(0,22), to_signed(0,22));

begin

--converting the input signal from 8-bit to 11-bit
x0(21 downto 14) <= input(0);
x2(21 downto 14) <= input(1);
x4(21 downto 14) <= input(2);
x6(21 downto 14) <= input(3);

u0 <= shift_right(x0,14);
u2 <= shift_right(x2,14);
u4 <= shift_right(x4,14);
u6 <= shift_right(x6,14);

--converting the output signal from 11-bit to 8-bit
output <= f_dec(7 downto 0);

m: process(clk)

begin
    if(rising_edge(clk)) then

        --updating internal registers
        u2reg(1) <= u2reg(0);
        u2reg(0) <= u2;        
        u4reg(1) <= u4reg(0);
        u4reg(0) <= u4;
        u0reg(4) <= u0reg(3);
        u0reg(3) <= u0reg(2);
        u0reg(2) <= u0reg(1);
        u0reg(1) <= u0reg(0);
        u0reg(0) <= u0;
        u6reg(3) <= u6reg(2);
        u6reg(2) <= u6reg(1);
        u6reg(1) <= u6reg(0);
        u6reg(0) <= u6;
        t1reg(2) <= t1reg(1);
        t1reg(1) <= t1reg(0);
        t3reg(2) <= t3reg(1);
        t3reg(1) <= t3reg(0);
        
        f_dec <= shift_right(t6+shift_left(t7, 9),11)+u0reg(4);
        t7 <= t3reg(2)+shift_left(u6reg(3),2);
        t6 <= t5-shift_left(t3reg(2),5);
        t5 <= shift_left(t4,4)+t1reg(2);
        t4 <= u4reg(1)-shift_left(u2reg(1),2);
        t3reg(0) <= t1reg(0)+shift_left(t2, 1);
        t2 <= shift_left(u4, 2)-u4;
        t1reg(0) <= shift_left(u2, 3)-u6;
                
    end if;
end process;

end arc;
