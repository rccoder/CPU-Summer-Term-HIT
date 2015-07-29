--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:17:51 07/24/2015
-- Design Name:   
-- Module Name:   C:/Users/rccoder/ALU/CPU/fetch_tb.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fetch
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
 
ENTITY fetch_tb IS
END fetch_tb;
 
ARCHITECTURE behavior OF fetch_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fetch
    PORT(
         irnew : IN  std_logic_vector(15 downto 0);
         pcnew : IN  std_logic_vector(15 downto 0);
         clk : IN  std_logic;
         pcupdate : IN  std_logic;
         reset : IN  std_logic;
         t0 : IN  std_logic;
         t1 : IN  std_logic;
         irout : OUT  std_logic_vector(15 downto 0);
         pcout : OUT  std_logic_vector(15 downto 0);
         irrep : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal irnew : std_logic_vector(15 downto 0) := (others => '0');
   signal pcnew : std_logic_vector(15 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal pcupdate : std_logic := '0';
   signal reset : std_logic := '0';
   signal t0 : std_logic := '0';
   signal t1 : std_logic := '0';

 	--Outputs
   signal irout : std_logic_vector(15 downto 0);
   signal pcout : std_logic_vector(15 downto 0);
   signal irrep : std_logic;

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fetch PORT MAP (
          irnew => irnew,
          pcnew => pcnew,
          clk => clk,
          pcupdate => pcupdate,
          reset => reset,
          t0 => t0,
          t1 => t1,
          irout => irout,
          pcout => pcout,
          irrep => irrep
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 100ns;
		reset <= '1';
		t0 <= '0';
		t1 <= '0';
		pcupdate <= '0';
		irnew <= "1111000011110000";
		pcnew <= "0000000011111111";
		
		wait for 100ns;
		reset <= '0';
		t0 <= '1';
		wait for 100ns;
		t0 <= '0';
		--pcupdate <= '1';
		wait for 150ns;
		pcupdate <= '0';
		t1 <= '1';
		wait for 100ns;
		pcupdate <= '1';
		t1 <= '0';
		wait for 100ns;
		reset <= '1';
		
      wait for clk_period*10;
		
		
      -- insert stimulus here 

      wait;
   end process;

END;
