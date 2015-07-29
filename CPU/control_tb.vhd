--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:02:47 07/28/2015
-- Design Name:   
-- Module Name:   C:/Users/rccoder/ALU/CPU/control_tb.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: control
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
 
ENTITY control_tb IS
END control_tb;
 
ARCHITECTURE behavior OF control_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT control
    PORT(
         IRreq : IN  std_logic;
         IR : OUT  std_logic_vector(15 downto 0);
         PCout : IN  std_logic_vector(15 downto 0);
         ALUOUT : IN  std_logic_vector(7 downto 0);
         Addr : IN  std_logic_vector(15 downto 0);
         ABUS : OUT  std_logic_vector(15 downto 0);
         DBUS : INOUT  std_logic_vector(15 downto 0);
         nWR : OUT  std_logic;
         nRD : OUT  std_logic;
         nMREQ : OUT  std_logic;
         nBHE : OUT  std_logic;
         nBLE : OUT  std_logic;
         nMWR : IN  std_logic;
         nMRD : IN  std_logic;
         data : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal IRreq : std_logic := '0';
   signal PCout : std_logic_vector(15 downto 0) := (others => '0');
   signal ALUOUT : std_logic_vector(7 downto 0) := (others => '0');
   signal Addr : std_logic_vector(15 downto 0) := (others => '0');
   signal nMWR : std_logic := '0';
   signal nMRD : std_logic := '0';

	--BiDirs
   signal DBUS : std_logic_vector(15 downto 0);

 	--Outputs
   signal IR : std_logic_vector(15 downto 0);
   signal ABUS : std_logic_vector(15 downto 0);
   signal nWR : std_logic;
   signal nRD : std_logic;
   signal nMREQ : std_logic;
   signal nBHE : std_logic;
   signal nBLE : std_logic;
   signal data : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: control PORT MAP (
          IRreq => IRreq,
          IR => IR,
          PCout => PCout,
          ALUOUT => ALUOUT,
          Addr => Addr,
          ABUS => ABUS,
          DBUS => DBUS,
          nWR => nWR,
          nRD => nRD,
          nMREQ => nMREQ,
          nBHE => nBHE,
          nBLE => nBLE,
          nMWR => nMWR,
          nMRD => nMRD,
          data => data
        );

   
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns
		
		
		--- ȡָ
		wait for 100 ns;
		nMRD <= '1';
		nMWR <= '1';
		DBUS <= "1111111111111111";
		IRreq <= '1';
		PCout <= "1111000011110000";
		
		wait for 100 ns;
		IRreq <= '0';
		nMRD <= '0';
		DBUS <= "1111111111111101";
		Addr <= "0101010101010101";
		
		wait for 100 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ"; --gaozu
		
		wait for 100 ns;
		nMRD <= '1';
		nMWR <= '0';
		ALUOUT <= "00001111";
		Addr <= "1010101010101010";
		

      wait;
   end process;

END;
