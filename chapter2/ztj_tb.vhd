
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:33:18 07/09/2015
-- Design Name:   zhuang
-- Module Name:   F:/xilinx sie13.4/zhuangtaiji/fz.vhd
-- Project Name:  zhuangtaiji
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: zhuang
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY fz_vhd IS
END fz_vhd;

ARCHITECTURE behavior OF fz_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT zhuang
	PORT(
		read_wright : IN std_logic;
		reset : IN std_logic;
		clk : IN std_logic;          
		oe : OUT std_logic;
		we : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL read_wright :  std_logic := '0';
	SIGNAL reset :  std_logic := '1';
	SIGNAL clk :  std_logic := '0';

	--Outputs
	SIGNAL oe :  std_logic;
	SIGNAL we :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: zhuang PORT MAP(
		read_wright => read_wright,
		reset => reset,
		clk => clk,
		oe => oe,
		we => we
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 20 ns;
		reset<='0';
		for i in 1 to 100 loop
		clk<=NOT clk;
		wait for 20 ns;
		clk<= NOT clk;
		wait for 20 ns;
		clk<= NOT clk;
		wait for 10 ns;
		read_wright<= NOT read_wright;
		wait for 10 ns;
		clk<= NOT clk;
		wait for 20 ns;
		clk<= NOT clk;	
		wait for 20 ns;
		clk<= NOT clk;
		read_wright<= NOT read_wright;
		end loop;
		-- Place stimulus here

		wait; -- will wait forever
	END PROCESS;

END;
