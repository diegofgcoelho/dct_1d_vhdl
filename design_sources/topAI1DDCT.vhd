----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2018 03:49:31 AM
-- Design Name: 
-- Module Name: topAI1DDCT - arc
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
--use IEEE.STD_LOGIC_ARITH.ALL;
library work;
use work.mypack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity topAI1DDCT is
    port (clk: in std_logic;
          err: out std_logic);
end topAI1DDCT;

architecture arc of topAI1DDCT is

component in_rom_memory is
   port(
      clk: in std_logic;
      addr: in std_logic_vector(9 downto 0);
      data0: out signed(7 downto 0);
      data1: out signed(7 downto 0);
      data2: out signed(7 downto 0);
      data3: out signed(7 downto 0);
      data4: out signed(7 downto 0);
      data5: out signed(7 downto 0);
      data6: out signed(7 downto 0);
      data7: out signed(7 downto 0)         
   );
end component;

component out_rom_memory is
   port(
      clk: in std_logic;
      addr: in std_logic_vector(9 downto 0);
      data0: out signed(7 downto 0);
      data1: out signed(7 downto 0);
      data2: out signed(7 downto 0);
      data3: out signed(7 downto 0);
      data4: out signed(7 downto 0);
      data5: out signed(7 downto 0);
      data6: out signed(7 downto 0);
      data7: out signed(7 downto 0)
   );
end component;

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

signal x0, x1, x2, x3, x4, x5, x6, x7: classA := to_signed(0, 8);
signal y0, y1, y2, y3, y4, y5, y6, y7: classA := to_signed(0, 8);
signal my0, my1, my2, my3, my4, my5, my6, my7: classA := to_signed(0, 8);
signal ry0, ry1, ry2, ry3, ry4, ry5, ry6, ry7: classA := to_signed(0, 8);
signal counter: unsigned(9 downto 0) := to_unsigned(0, 10);

signal y0reg, y1reg, y2reg, y3reg, y4reg, y5reg, y6reg, y7reg: signed(63 downto 0) := to_signed(0,64);

begin

inmemory: in_rom_memory
port map(
      clk => clk,
      addr => std_logic_vector(counter),
      data0 => x0,
      data1 => x1,
      data2 => x2,
      data3 => x3,
      data4 => x4,
      data5 => x5,
      data6 => x6,
      data7 => x7         
   );

outmemory: out_rom_memory
port map(
      clk => clk,
      addr => std_logic_vector(counter),
      data0 => my0,
      data1 => my1,
      data2 => my2,
      data3 => my3,
      data4 => my4,
      data5 => my5,
      data6 => my6,
      data7 => my7         
   );

DCTblck: AI1DDCT
port map (clk => clk,
          x0 => x0,
          x1 => x1,
          x2 => x2,
          x3 => x3,
          x4 => x4,
          x5 => x5,
          x6 => x6,
          x7 => x7,
          y0 => y0,
          y1 => y1,
          y2 => y2,
          y3 => y3,
          y4 => y4,
          y5 => y5,
          y6 => y6,
          y7 => y7);

ry0 <= y0reg(63 downto 56);
ry1 <= y1reg(63 downto 56);
ry2 <= y2reg(63 downto 56);
ry3 <= y3reg(63 downto 56);
ry4 <= y4reg(63 downto 56);
ry5 <= y5reg(63 downto 56);
ry6 <= y6reg(63 downto 56);
ry7 <= y7reg(63 downto 56);

--process to increment the counters in steps of 8
inc:process(clk)
begin
    if(rising_edge(clk)) then
        counter <= counter+to_unsigned(8, 10);
    end if;
end process;

--updating the registers
upd:process(clk)
begin
    if(rising_edge(clk)) then
        
        y0reg(63 downto 8) <= y0reg(55 downto 0);
        y0reg(7 downto 0) <= my0;
        
        y1reg(63 downto 8) <= y1reg(55 downto 0);
        y1reg(7 downto 0) <= my1; 
 
        y2reg(63 downto 8) <= y2reg(55 downto 0);
        y2reg(7 downto 0) <= my2; 

        y3reg(63 downto 8) <= y3reg(55 downto 0);
        y3reg(7 downto 0) <= my3; 

        y4reg(63 downto 8) <= y4reg(55 downto 0);
        y4reg(7 downto 0) <= my4; 

        y5reg(63 downto 8) <= y5reg(55 downto 0);
        y5reg(7 downto 0) <= my5; 

        y6reg(63 downto 8) <= y6reg(55 downto 0);
        y6reg(7 downto 0) <= my6; 

        y7reg(63 downto 8) <= y7reg(55 downto 0);
        y7reg(7 downto 0) <= my7; 

    end if;
end process;

--checking for equality
chk:process(clk)
begin
    if(rising_edge(clk)) then
        if(counter > to_unsigned(56, 10)) then
            if(ry0 = y0 and ry1 = y1 and ry2 = y2 and ry3 = y3 and ry3 = y3 and ry4 = y4 and ry5 = y5 and ry6 = y6 and ry7 = y7) then
                err <= '0';
            else
                err <= '1';
            end if;
        else
            err <= '0';
        end if;
    end if;
end process;


end arc;
