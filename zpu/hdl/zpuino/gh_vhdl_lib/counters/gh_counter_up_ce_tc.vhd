-----------------------------------------------------------------------------
--	Filename:	gh_Counter_up_ce_tc.vhd
--
--	Description:
--		Binary up/down counter with load, count enable and TC
--
--	Copyright (c) 2005 by George Huber 
--		an OpenCores.org Project
--		free to use, but see documentation for conditions  
--
--	Revision 	History:
--	Revision 	Date       	Author   	Comment
--	-------- 	---------- 	---------	-----------
--	1.0      	09/03/05  	S A Dodd	Initial revision 
--	2.0     	09/17/05  	h lefevre	name change to avoid conflict
--	        	          	         	  with other libraries
--	2.1     	09/24/05  	S A Dodd 	fix description
--	2.2      	05/21/06  	S A Dodd 	fix typo's
--
-----------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

ENTITY gh_counter_up_ce_tc IS
	GENERIC (size: INTEGER :=8);
	PORT(
		CLK   : IN	STD_LOGIC;
		rst   : IN	STD_LOGIC;
		CE    : IN	STD_LOGIC;
		Q     : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		TC    : OUT STD_LOGIC
		);
END gh_counter_up_ce_tc;

ARCHITECTURE a OF gh_counter_up_ce_tc IS 

	signal iQ : STD_LOGIC_VECTOR (size-1 DOWNTO 0);
	signal iTC : STD_LOGIC;
	
BEGIN

--
-- outputs

	TC <= (iTC and CE);
	      
	Q <= iQ;

----------------------------------
----------------------------------

PROCESS (CLK,rst)
BEGIN
	if (rst = '1') then 
		iTC <= '0';
	elsif (rising_edge(CLK)) then
		if (CE = '0') then
			if (iQ = (2**size - 1)) then
				iTC <= '1';
			else
				iTC <= '0';
			end if;			
		else -- (CE = '1')	
			if (iQ = (2**size - 2)) then
				iTC <= '1';
			else
				iTC <= '0';
			end if;
		end if;			
	end if;
END PROCESS;


PROCESS (CLK,rst)
BEGIN
	if (rst = '1') then 
		iQ <= (others => '0');
	elsif (rising_edge(CLK)) then
		if (CE = '1') then
			iQ <= (iQ + "01");
		end if;			
	end if;
END PROCESS;

END a;
