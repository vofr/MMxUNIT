----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2023 06:29:53 PM
-- Design Name: 
-- Module Name: reg_file - Behavioral
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
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_file is
	port(  
	clk: in std_logic;                           
	instr: in std_logic_vector(2 downto 0);     
	src_select: in std_logic_vector(2 downto 0);
	dest_select: in std_logic_vector(2 downto 0);
	
	src_out:  out std_logic_vector(63 downto 0);
	dest_out: out std_logic_vector(63 downto 0)
	);
end reg_file;

architecture beh of reg_file is
type vec_array64 is array( 0 to 7) of std_logic_vector(63 downto 0);	
signal reg_array: vec_array64;
                   

begin
	-- populate registers
	reg_array(0)<=x"0000000000000001";
	reg_array(1)<=x"0000000000000002";
	reg_array(2)<=x"000000000000000B";
	reg_array(3)<=x"000000000000000A";
	reg_array(4)<=x"0000000000000005";
	reg_array(5)<=x"0000000000000000";
	reg_array(6)<=x"0000000000000009";
	reg_array(7)<=x"000000000000000F";
                         
	read:  --read a value from the register file
	process(instr,clk,src_select,dest_select,reg_array) 
	variable src_read:  std_logic_vector(2 downto 0) := "000"; --selects registers to read
	variable dest_read: std_logic_vector(2 downto 0) := "000";
	begin  
		
		src_read  := src_select(2 downto 0);
		dest_read := dest_select(2 downto 0);
		
		--Output appropriate register values--
		src_out  <= reg_array( to_integer(unsigned(src_read)) );
		dest_out <= reg_array( to_integer(unsigned(dest_read)) );
			
	end process;  
	
end beh;
