----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2023 06:42:57 PM
-- Design Name: 
-- Module Name: SSD - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SSD is
    Port ( clk : in STD_LOGIC;
           cnt2:in std_logic_vector(15 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end SSD;

architecture Behavioral of SSD is

signal cnt:std_logic_vector(15 downto 0):=x"0000";

signal nbr:std_logic_vector(3 downto 0):=x"0";

component Numarator16b 
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0));
end component;

begin



process(clk)
begin

  if(rising_edge(clk))then 
     cnt<=cnt+1;
     end if;
end process;


process(cnt(14),cnt(15))
begin

if(cnt(14)='0')then
   if(cnt(15)='0')then
      an<="1110";
      nbr<=cnt2(3)&cnt2(2)&cnt2(1)&cnt2(0);
      elsif(cnt(15)='1')then an<="1011";
      nbr<=cnt2(11)&cnt2(10)&cnt2(9)&cnt2(8);
      end if;
    elsif(cnt(15)='0')then
       an<="1101";
       nbr<=cnt2(7)&cnt2(6)&cnt2(5)&cnt2(4);
       else an<="0111";
       nbr<=cnt2(15)&cnt2(14)&cnt2(13)&cnt2(12);
       end if;    
end process;

process(nbr)
begin
   case nbr is
      when "0000"=>cat<="1000000";
      when "0001"=>cat<="1111001";
      when "0010"=>cat<="0100100";
      when "0011"=>cat<="0110000";
      when "0100"=>cat<="0011001";
      when "0101"=>cat<="0010010";
      when "0110"=>cat<="0000010";
      when "0111"=>cat<="1111000";
      when "1000"=>cat<="0000000";
      when "1010"=>cat<="0001000";
      when "1011"=>cat<="0000011";
      when "1100"=>cat<="1000110";
      when "1101"=>cat<="0100001";
      when "1110"=>cat<="0000110";
      when "1111"=>cat<="0001110";
      when others=>cat<="0010000";
   end case;
end process;


end Behavioral;
