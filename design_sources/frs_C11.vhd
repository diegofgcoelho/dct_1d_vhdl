----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2018 12:12:05 AM
-- Design Name: 
-- Module Name: frs_C11 - arc
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: This design implements the FRS for class C AI quantities
-- using the dyadic approximation method with 11-bits constants.
-- Latency: 4 clock cycles.
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

entity frs_C11 is
    port(clk : in std_logic;
    input: in classC;
    output: out classA);
end frs_C11;

architecture arc of frs_C11 is

signal t1, t2, t3, t4, t5, t6, f_dec: signed(21 downto 0):= to_signed(0,22);
signal x2, x6: signed(21 downto 0):= to_signed(0,22);
signal u2, u6: signed(21 downto 0):= to_signed(0,22);

begin

--converting the input signal from 8-bit to 11-bit
x2(21 downto 14) <= input(0);
x6(21 downto 14) <= input(1);

u2 <= shift_right(x2,14);
u6 <= shift_right(x6,14);

--converting the output signal from 11-bit to 8-bit
output <= f_dec(7 downto 0);

m: process(clk)

begin
    if(rising_edge(clk)) then
        
        f_dec <= shift_right(t3+t6,11);
        t6 <= t4+t5;
        t5 <= shift_left(u2,12)-shift_left(u2,8);
        t4 <= -shift_left(u2,6)+shift_left(u2,3);
        t3 <= t1+t2;
        t2 <= shift_left(u6,11)-shift_left(u6,9);
        t1 <= shift_left(u6,5)-u6;        
        
    end if;
end process;

end arc;


--signal t1, t2, t3, t4, t5, t6, t7, f_dec: signed(21 downto 0):= to_signed(0,22);
--signal x2, x6: signed(21 downto 0):= to_signed(0,22);
--signal u2, u6: signed(21 downto 0):= to_signed(0,22);
--type ureg is array (natural range <>) of signed(21 downto 0);
--signal t1reg: ureg(2 downto 0) := (to_signed(0,22), to_signed(0,22), to_signed(0,22));

--begin

----converting the input signal from 8-bit to 11-bit
--x2(21 downto 14) <= input(0);
--x6(21 downto 14) <= input(1);

--u2 <= shift_right(x2,14);
--u6 <= shift_right(x6,14);

----converting the output signal from 11-bit to 8-bit
--output <= f_dec(7 downto 0);

--m: process(clk)

--begin
--    if(rising_edge(clk)) then
        
--        f_dec <= shift_right(shift_left(t1, 11)+t7,11);
--        t7 <= shift_left(t6,6)+t5;
--        t6 <= -shift_left(t4, 3)+t3;
--        t5 <= shift_left(t2,4)-t1;
--        t4 <= shift_left(u2, 1)+u6;
--        t3 <= shift_left(u2, 2)+u2;
--        t2 <= shift_left(u6, 1)+u2;
--        t1 <= shift_left(u2,1)+u6;
        
--        --updating internal registers
--        t1reg(2) <= t1reg(1);
--        t1reg(1) <= t1reg(0);
--        t1reg(0) <= t1;
        
--    end if;
--end process;

--end arc;
