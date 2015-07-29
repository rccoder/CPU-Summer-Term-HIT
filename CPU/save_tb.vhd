--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:24:21 07/28/2015
-- Design Name:   
-- Module Name:   C:/Users/rccoder/ALU/CPU/save_tb.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: save
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY save_tb IS
END save_tb;
 
ARCHITECTURE behavior OF save_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT save
    PORT(
         t : IN  std_logic;
         ALUOUT : IN  std_logic_vector(7 downto 0);
         data : IN  std_logic_vector(7 downto 0);
         nMWR : OUT  std_logic;
         IR : IN  std_logic_vector(15 downto 0);
         nMRD : OUT  std_logic;
         Rtemp : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal t : std_logic := '0';
   signal ALUOUT : std_logic_vector(7 downto 0) := (others => '0');
   signal data : std_logic_vector(7 downto 0) := (others => '0');
   signal IR : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal nMWR : std_logic;
   signal nMRD : std_logic;
   signal Rtemp : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: save PORT MAP (
          t => t,
          ALUOUT => ALUOUT,
          data => data,
          nMWR => nMWR,
          IR => IR,
          nMRD => nMRD,
          Rtemp => Rtemp
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		t <= '0';
		wait for 100 ns;
		t <= '1';
		IR <= "1101100000000000";   --È¡Êý
		data <= "01010011";
		wait for 100 ns;
		IR <= "1100000000000000";   --´æÊý
		ALUOUT <= "11110000";
      -- insert stimulus here 

      wait;
   end process;

END;
