----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2018 12:12:05 AM
-- Design Name: 
-- Module Name: frs_E11 - arc
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: This design implements the FRS for class E AI quantities
-- using the dyadic approximation method with 11-bits constants.
-- Latency: 3 clock cycles.
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

entity frs_E11 is
    port(clk : in std_logic;
    input: in classC;
    output: out classA);
end frs_E11;

architecture arc of frs_E11 is

signal t1, t2, f_dec: signed(21 downto 0):= to_signed(0,22);
signal x0, x4: signed(21 downto 0):= to_signed(0,22);
signal u0, u4: signed(21 downto 0):= to_signed(0,22);
type ureg is array (natural range <>) of signed(21 downto 0);
signal u0reg, u4reg: ureg(1 downto 0) := (to_signed(0,22), to_signed(0,22));

begin

--converting the input signal from 8-bit to 11-bit
x0(21 downto 14) <= input(0);
x4(21 downto 14) <= input(1);

u0 <= shift_right(x0,14);
u4 <= shift_right(x4,14);

--converting the output signal from 11-bit to 8-bit
output <= f_dec(7 downto 0);

m: process(clk)

begin
    if(rising_edge(clk)) then
        
        f_dec <= shift_right(shift_left(u4reg(1), 12)-shift_left(t2, 4),11)+u0reg(1);
        t2 <= shift_left(t1, 2)+t1;
        t1 <= -u4+shift_left(u4,4);
        
        --updating internal registers
        u0reg(1) <= u0reg(0);
        u0reg(0) <= u0;
        u4reg(1) <= u4reg(0);
        u4reg(0) <= u4;

    end if;
end process;

end arc;
