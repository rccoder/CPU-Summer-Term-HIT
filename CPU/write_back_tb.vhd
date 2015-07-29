--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:18:44 07/28/2015
-- Design Name:   
-- Module Name:   C:/Users/rccoder/ALU/CPU/write_back_tb.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: write_back
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
 
ENTITY write_back_tb IS
END write_back_tb;
 
ARCHITECTURE behavior OF write_back_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT write_back
    PORT(
         PCin : IN  std_logic_vector(15 downto 0);
         t : IN  std_logic;
         Rtemp : IN  std_logic_vector(7 downto 0);
         IR : IN  std_logic_vector(15 downto 0);
         z : IN  std_logic;
         cy : IN  std_logic;
         Rupdate : OUT  std_logic;
         Rdata : OUT  std_logic_vector(7 downto 0);
         PCupdate : OUT  std_logic;
         PCnew : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PCin : std_logic_vector(15 downto 0) := (others => '0');
   signal t : std_logic := '0';
   signal Rtemp : std_logic_vector(7 downto 0) := (others => '0');
   signal IR : std_logic_vector(15 downto 0) := (others => '0');
   signal z : std_logic := '0';
   signal cy : std_logic := '0';

 	--Outputs
   signal Rupdate : std_logic;
   signal Rdata : std_logic_vector(7 downto 0);
   signal PCupdate : std_logic;
   signal PCnew : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: write_back PORT MAP (
          PCin => PCin,
          t => t,
          Rtemp => Rtemp,
          IR => IR,
          z => z,
          cy => cy,
          Rupdate => Rupdate,
          Rdata => Rdata,
          PCupdate => PCupdate,
          PCnew => PCnew
        );

  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		t <= '0';
		
		wait for 100 ns;
		t <= '1'; ---JMP
		IR <= "1000100001010101";
		
		wait for 100 ns;
		t <= '0';
		
		wait for 100 ns;
		t <= '1';
		IR <= "1000000000001111";
		z <= '1';
		
		wait for 100 ns;
		t <= '0';
		
		wait for 100 ns;
		t <= '1';
		IR <= "1000001000001101";
		z <= '0';
		
		wait for 100 ns;
		t <= '0';
		
		wait for 100 ns;
		t <= '1';
		IR <= "1100011111110000";   -- STA
		
		wait for 100 ns;
		t <= '0';
		
		wait for 100 ns;
		t <= '1';
		IR <= "0001000100000010";
		Rtemp <= "11111111";
      -- insert stimulus here 

      wait;
   end process;

END;
