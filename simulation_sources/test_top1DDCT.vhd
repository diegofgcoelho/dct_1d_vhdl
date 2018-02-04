----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2018 12:16:49 AM
-- Design Name: 
-- Module Name: test_top1DDCT - arc
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

entity test_topAI1DDCT is
--  Port ( );
end test_topAI1DDCT;

architecture arc of test_topAI1DDCT is

component topAI1DDCT is
    port (clk: in std_logic;
          err: out std_logic);
end component;

signal clk, serr: std_logic := '0';
constant clk_period: time:= 20 ns;

begin

uut: topAI1DDCT
port map (clk => clk,
          err => serr);

clkp: process
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;

end arc;
