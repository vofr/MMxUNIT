----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2023 06:39:00 PM
-- Design Name: 
-- Module Name: MMx_Unit - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MMx_Unit is
 Port (
    clk: in std_logic;                               
    sw : in STD_LOGIC_VECTOR (15 downto 0);
    an : out STD_LOGIC_VECTOR (3 downto 0);
    cat : out STD_LOGIC_VECTOR (6 downto 0));
end MMx_Unit;

architecture Behavioral of MMx_Unit is

component alu is
	port( 		  
	src:  in std_logic_vector(63 downto 0);	
	dest: in std_logic_vector(63 downto 0);	
	instr:  in std_logic_vector(2 downto 0);	
	
	res: out std_logic_vector(63 downto 0));
end component;

component reg_file is
	port(  
	clk: in std_logic;                           
	instr: in std_logic_vector(2 downto 0);     
	src_select: in std_logic_vector(2 downto 0);
	dest_select: in std_logic_vector(2 downto 0);
	
	src_out:  out std_logic_vector(63 downto 0);
	dest_out: out std_logic_vector(63 downto 0)
	);
end component;

component SSD is
    Port ( clk: in STD_LOGIC;
           cnt2: in STD_LOGIC_VECTOR(15 downto 0);
           an: out STD_LOGIC_VECTOR(3 downto 0);
           cat: out STD_LOGIC_VECTOR(6 downto 0));
end component;

--Signals declarations
signal cnt2 : std_logic_vector(15 downto 0);
signal alu_out : std_logic_vector (63 downto 0);
signal src_reg_out, dest_reg_out: std_logic_vector(63 downto 0);
signal instruction : std_logic_vector(15 downto 0);
signal src_select_unit: std_logic_vector(2 downto 0);
signal dest_select_unit: std_logic_vector(2 downto 0);
signal instr : std_logic_vector(2 downto 0);

begin
instr <=sw(12 downto 10);               --instruction select    
instruction <= "0000000000000" & instr; --cnt2 16 bits
dest_select_unit <= sw(9 downto 7);     --dest select
src_select_unit <= sw(6 downto 4);      --src select
with sw(15 downto 13) select
        cnt2 <=  instruction when "000",
                 alu_out(15 downto 0) when "001",
                 alu_out(31 downto 16) when "010",
                 alu_out(47 downto 32) when "011",
                 alu_out(63 downto 48) when "100",
                 src_reg_out(15 downto 0) when "101",
                 dest_reg_out(15 downto 0) when "110",
                 (others => '0') when others; 
                 
display : SSD port map (clk => clk,cnt2 => cnt2,an => an,cat => cat); --display on basys3

reg_fil: reg_file port map(
         clk => clk,
         instr => instr,
         src_select => src_select_unit(2 downto 0),
         dest_select => dest_select_unit(2 downto 0),
         src_out => src_reg_out,       --return value of register
         dest_out => dest_reg_out);    --return value of register
         
alu_unit: alu port map(
         src => src_reg_out,
         dest => dest_reg_out,
         instr => instr,
         res => alu_out     -- result
);
end Behavioral;
