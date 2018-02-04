----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2018 08:08:48 PM
-- Design Name: 
-- Module Name: test_frs_D11 - arc
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

entity test_frs_D11 is
--  Port ( );
end test_frs_D11;

architecture arc of test_frs_D11 is

component frs_D11 is
    port(clk : in std_logic;
    input: in classD;
    output: out classA);
end component;

signal clk: std_logic;
signal tin: classD;
signal tout: classA;
constant clk_period: time:= 20 ns;


begin

uut: frs_D11
    port map(clk => clk,
            input => tin,
            output => tout);

stim: process
begin
    tin <= ("11111110", "00001110", "00001111", "11011110"); 
    wait for clk_period;
    
    tin <= ("11101110", "11111110", "00001110", "00001111"); 
    wait for clk_period;
    
    tin <= ("00111110", "10111110", "11111110", "00001110"); 
    wait for clk_period;

    tin <= ("00001110", "00011110", "10111110", "11111110"); 
    wait for clk_period;

end process;


clkp: process
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;


end arc;
