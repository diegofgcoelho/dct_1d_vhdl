----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2018 02:04:45 AM
-- Design Name: 
-- Module Name: AI1DDCT - arc
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

entity AI1DDCT is
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
end AI1DDCT;

architecture arc of AI1DDCT is

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

component frs_B11 is
    port(clk : in std_logic;
        input: in classB;
        output: out classA);
end component;

component frs_C11 is
    port(clk : in std_logic;
    input: in classC;
    output: out classA);
end component;

signal sclk: std_logic := '0';
signal sx0, sx1, sx2, sx3, sx4, sx5, sx6, sx7: classA := to_signed(0,8);
signal sy1, sy3, sy5, sy7: classA := to_signed(0,8);
signal yai1, yai3, yai5, yai7: classB := (to_signed(0,8), to_signed(0,8), to_signed(0,8), to_signed(0,8));
signal yai2, yai6: classC := (to_signed(0,8), to_signed(0,8));
signal sy0reg, sy4reg: signed(39 downto 0):= to_signed(0, 40);
signal sy2reg, sy6reg: signed(15 downto 0):= to_signed(0, 16);

begin

sclk <= clk;

--Assgning input
sx0 <= x0;
sx1 <= x1;
sx2 <= x2;
sx3 <= x3;
sx4 <= x4;
sx5 <= x5;
sx6 <= x6;
sx7 <= x7;
--Assigning output
y0 <= sy0reg(39 downto 32);
y1 <= sy1;
y2 <= sy2reg(15 downto 8);
y3 <= sy3;
y4 <= sy4reg(39 downto 32);
y5 <= sy5;
y6 <= sy6reg(15 downto 8);
y7 <= sy7;

uutDCT: ClassA1DDCT
  port map (clk => sclk,
        x0 => sx0,
        x1 => sx1,
        x2 => sx2,
        x3 => sx3,
        x4 => sx4,
        x5 => sx5,
        x6 => sx6,
        x7 => sx7,
        y0 => sy0reg(7 downto 0),
        y1 => yai1,
        y2 => yai2,
        y3 => yai3,
        y4 => sy4reg(7 downto 0),
        y5 => yai5,
        y6 => yai6,
        y7 => yai7);

uutFRS1: frs_B11
    port map(clk => sclk,
        input => yai1,
        output => sy1);

uutFRS2: frs_C11
    port map(clk => sclk,
        input => yai2,
        output => sy2reg(7 downto 0));


uutFRS3: frs_B11
    port map(clk => sclk,
        input => yai3,
        output => sy3);

uutFRS5: frs_B11
    port map(clk => sclk,
        input => yai5,
        output => sy5);

uutFRS6: frs_C11
    port map(clk => sclk,
        input => yai6,
        output => sy6reg(7 downto 0));

uutFRS7: frs_B11
    port map(clk => sclk,
        input => yai7,
        output => sy7);

--update internal registers
m:process(clk)
begin
    if(rising_edge(clk)) then
        sy0reg(39 downto 8) <= sy0reg(31 downto 0);
        sy4reg(39 downto 8) <= sy4reg(31 downto 0);
        sy2reg(15 downto 8) <= sy2reg(7 downto 0);
        sy6reg(15 downto 8) <= sy6reg(7 downto 0);
    end if;
end process;

end arc;
