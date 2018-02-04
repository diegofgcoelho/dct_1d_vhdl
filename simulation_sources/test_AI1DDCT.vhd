----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2018 02:22:52 AM
-- Design Name: 
-- Module Name: test_AI1DDCT - arc
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

entity test_AI1DDCT is
--  Port ( );
end test_AI1DDCT;

architecture arc of test_AI1DDCT is

component AI1DDCT is
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
          y1: out classA;
          y2: out classA;
          y3: out classA;
          y4: out classA;
          y5: out classA;
          y6: out classA;
          y7: out classA);
end component;


signal clk: std_logic:='0';
type uvec is array (natural range <>) of classA;
signal tin: uvec(7 downto 0):= (to_signed(0,8), to_signed(0,8), to_signed(0,8), to_signed(0,8), to_signed(0,8), to_signed(0,8), to_signed(0,8), to_signed(0,8));
signal tout:  uvec(7 downto 0):= (to_signed(0,8), to_signed(0,8), to_signed(0,8), to_signed(0,8), to_signed(0,8), to_signed(0,8), to_signed(0,8), to_signed(0,8));
constant clk_period: time:= 20 ns;

begin

uut: AI1DDCT
    port map(clk => clk,
          x0 => tin(0),
          x1 => tin(1),
          x2 => tin(2),
          x3 => tin(3),
          x4 => tin(4),
          x5 => tin(5),
          x6 => tin(6),
          x7 => tin(7),
          y0 => tout(0),
          y1 => tout(1),
          y2 => tout(2),
          y3 => tout(3),
          y4 => tout(4),
          y5 => tout(5),
          y6 => tout(6),
          y7 => tout(7));

stim: process
begin
    tin <= (to_signed(-7,8), to_signed(-8,8), to_signed(13,8), to_signed(-17,8), to_signed(15,8), to_signed(12,8), to_signed(8,8), to_signed(5,8)); 
    wait for 20*clk_period;
    
    tin <= (to_signed(-7,8), to_signed(-8,8), to_signed(13,8), to_signed(17,8), to_signed(15,8), to_signed(12,8), to_signed(8,8), to_signed(5,8)); 
    wait for 20*clk_period;
    
    tin <= (to_signed(-7,8), to_signed(-8,8), to_signed(13,8), to_signed(17,8), to_signed(15,8), to_signed(12,8), to_signed(10,8), to_signed(5,8)); 
    wait for 20*clk_period;

    tin <= (to_signed(-7,8), to_signed(8,8), to_signed(13,8), to_signed(17,8), to_signed(15,8), to_signed(12,8), to_signed(10,8), to_signed(5,8)); 
    wait for 20*clk_period;

end process;

clkp: process
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;

end arc;
