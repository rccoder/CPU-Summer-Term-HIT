
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:13:46 07/09/2015
-- Design Name:   ALU
-- Module Name:   C:/Xilinx91i/ALU/ALU_tb.vhd
-- Project Name:  ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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

ENTITY ALU_tb_vhd IS
END ALU_tb_vhd;

ARCHITECTURE behavior OF ALU_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT ALU
	PORT(
		A : IN std_logic_vector(7 downto 0);
		B : IN std_logic_vector(7 downto 0);
		Cin : IN std_logic;
		Card : IN std_logic_vector(4 downto 0);          
		F : OUT std_logic_vector(7 downto 0);
		Cout : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL Cin :  std_logic := '0';
	SIGNAL A :  std_logic_vector(7 downto 0) := (others=>'0');
	SIGNAL B :  std_logic_vector(7 downto 0) := (others=>'0');
	SIGNAL Card :  std_logic_vector(4 downto 0) := (others=>'0');

	--Outputs
	SIGNAL F :  std_logic_vector(7 downto 0) := (others => '0');
	SIGNAL Cout :  std_logic := '0';

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: ALU PORT MAP(
		A => A,
		B => B,
		Cin => Cin,
		Card => Card,
		F => F,
		Cout => Cout
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 50 ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '0';
		Card <= "00000";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '0';
		Card <= "00001";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '0';
		Card <= "00010";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '0';
		Card <= "00011";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '0';
		Card <= "00100";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '0';
		Card <= "00101";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '0';
		Card <= "00110";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '0';
		Card <= "00111";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '1';
		Card <= "01000";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '1';
		Card <= "01001";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '1';
		Card <= "01010";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '1';
		Card <= "01011";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '1';
		Card <= "01100";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '1';
		Card <= "01101";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '1';
		Card <= "01110";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '1';
		Card <= "01111";
		
		wait for 50ns;
		
		A <= "11111111";
		B <= "10000000";
		Cin <= '1';
		Card <= "01111";
		-- Place stimulus here

		wait; -- will wait forever
	END PROCESS;

END;
