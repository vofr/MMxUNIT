-------------------------------------
--VHDL Version: 1076-2008
--Tool name:	Aldec Active HDL 11.1
--Module Name:  alu
--Description:  Accepts two operands from register file and a 3-byte
--instruction, executes the instruction, and outputs the result
-------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port( 		  
	src:  in std_logic_vector(63 downto 0);	--source register
	dest: in std_logic_vector(63 downto 0);	--destination register
	instr:  in std_logic_vector(2 downto 0);	--instruction to execute
	
	res: out std_logic_vector(63 downto 0)  --result
	);
end alu;  

architecture beh of alu is	

--INSTRUCTIONS:	 

--paddb
impure function paddb return std_logic_vector is		 
variable result: unsigned(63 downto 0) := (others=>'0');
variable srcu:   unsigned(63 downto 0) := unsigned(src);
variable destu:  unsigned(63 downto 0) := unsigned(dest);
begin	 
	result(7 downto 0)   := srcu(7 downto 0) + destu(7 downto 0);
	result(15 downto 8)  := srcu(15 downto 8) + destu(15 downto 8);
	result(23 downto 16) := srcu(23 downto 16) + destu(23 downto 16);
	result(31 downto 24) := srcu(31 downto 24) + destu(31 downto 24);
	result(39 downto 32) := srcu(39 downto 32) + destu(39 downto 32);
	result(47 downto 40) := srcu(47 downto 40) + destu(47 downto 40);
	result(55 downto 48) := srcu(55 downto 48) + destu(55 downto 48);
	result(63 downto 56) := srcu(63 downto 56) + destu(63 downto 56);
	return std_logic_vector(result);
end paddb;		   

--paddw
impure function paddw return std_logic_vector is		 
variable result: unsigned(63 downto 0) := (others=>'0');
variable srcu:   unsigned(63 downto 0) := unsigned(src);
variable destu:  unsigned(63 downto 0) := unsigned(dest);
begin	 
	result(15 downto 0)  := srcu(15 downto 0)  + destu(15 downto 0);
	result(31 downto 16) := srcu(31 downto 16) + destu(31 downto 16);
	result(47 downto 32) := srcu(47 downto 32) + destu(47 downto 32);
	result(63 downto 48) := srcu(63 downto 48) + destu(63 downto 48);
	return std_logic_vector(result);
end paddw;	


--paddd
impure function paddd return std_logic_vector is		 
variable result: unsigned(63 downto 0) := (others=>'0');
variable srcu:   unsigned(63 downto 0) := unsigned(src);
variable destu:  unsigned(63 downto 0) := unsigned(dest);
begin	 
	result(31 downto 0)  := srcu(31 downto 0) + destu(31 downto 0);
	result(63 downto 32) := srcu(63 downto 32) + destu(63 downto 32);
	return std_logic_vector(result);
end paddd; 

--pmulq
impure function pmulq return std_logic_vector is
variable result: unsigned(127 downto 0) := (others=>'0');
variable srcu: unsigned(63 downto 0) := unsigned(src);
variable destu: unsigned(63 downto 0) := unsigned(dest);
begin
      result := srcu * destu;
      return std_logic_vector(result(63 downto 0));
end pmulq;

--Main ALU operation
begin	
	
	main: process(src, dest, instr)		
	begin 
		
		case instr(2 downto 0) is
		    when "000" => res <= pmulq;
			when "001" => res <= src;          --movq 
			when "010" => res <= src and dest; --pand
			when "011" => res <= src or dest;	--por
			when "100" => res <= src nand dest;--pandn
			when "101" => res <= src xor dest;	--pxor
			when "110" => res <= paddb;
			when "111" => res <= paddw;
			when others => res <= X"0000000000000000";			
		end case;  
		
	end process;

end beh;
	
