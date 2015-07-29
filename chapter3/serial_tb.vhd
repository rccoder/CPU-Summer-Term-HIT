--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:46:33 07/16/2015
-- Design Name:   
-- Module Name:   C:/Users/rccoder/ALU/Lab3/serial_tb.vhd
-- Project Name:  Lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: serial
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
 
ENTITY serial_tb IS
END serial_tb;
 
ARCHITECTURE behavior OF serial_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT serial
    PORT(
         serialdata : IN  std_logic;
         clk : IN  std_logic;
         csn : IN  std_logic;
         wrn : IN  std_logic;
         rdn : IN  std_logic;
         addr : IN  std_logic_vector(1 downto 0);
         data : INOUT  std_logic_vector(7 downto 0);
         intn : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal serialdata : std_logic := '0';
   signal clk : std_logic := '0';
   signal csn : std_logic := '0';
   signal wrn : std_logic := '0';
   signal rdn : std_logic := '0';
   signal addr : std_logic_vector(1 downto 0) := (others => '0');

	--BiDirs
   signal data : std_logic_vector(7 downto 0);

 	--Outputs
   signal intn : std_logic;

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: serial PORT MAP (
          serialdata => serialdata,
          clk => clk,
          csn => csn,
          wrn => wrn,
          rdn => rdn,
          addr => addr,
          data => data,
          intn => intn
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
		wrn <= '0';
		csn<='0';
		rdn<='1';
		addr<="01";
		wait for 100 ns;
		addr<="10";
		wait for 100 ns;
		addr<="11";
		wait for 100 ns;
		addr<="00";
		wait for 100 ns;	
		rdn<='0';
		csn<='0';
		wrn<='1';
		--wait for 100 ns;
		--serialdata <= '0';
      wait for 100 ns;	
		
		serialdata <= '0';
		wait for 100 ns;	
		serialdata <= '0';
		wait for 100 ns;	
		serialdata <= '0';
		wait for 100 ns;	
		serialdata <= '0';
		wait for 100 ns;	
		serialdata <= '1';
		wait for 100 ns;	
		serialdata <= '1';
		wait for 100 ns;	
		serialdata <= '1';
		wait for 100 ns;	
		serialdata <= '1';
		wait for 100 ns;
		
		serialdata <= '0';
		wait for 100 ns;
		serialdata <= '1';
		wait for 100 ns;
		serialdata <= '1';
		wait for 100 ns;
		
		addr<="01";
		wait for 100 ns;
		
		
		
		
		
		wrn <= '0';
		csn<='0';
		rdn<='1';
		addr<="01";
		wait for 100 ns;
		addr<="10";
		wait for 100 ns;
		addr<="11";
		wait for 100 ns;
		addr<="00";
		wait for 100 ns;	
		rdn<='0';
		csn<='0';
		wrn<='1';
		wait for 100 ns;	
		
		serialdata <= '0';
		wait for 100 ns;	
		
		serialdata <= '0';
		wait for 100 ns;	
		serialdata <= '0';
		wait for 100 ns;	
		serialdata <= '0';
		wait for 100 ns;	
		serialdata <= '0';
		wait for 100 ns;	
		serialdata <= '1';
		wait for 100 ns;	
		serialdata <= '1';
		wait for 100 ns;	
		serialdata <= '1';
		wait for 100 ns;	
		serialdata <= '1';
		wait for 100 ns;
		
		serialdata <= '1';
		wait for 100 ns;
		serialdata <= '1';
		wait for 100 ns;
		serialdata <= '1';
		wait for 100 ns;
		
		addr<="01";
		wait for 100 ns;
		
		
		
		addr<="00";
		wait for 100 ns;
		serialdata <= '0';
		wait for 300 ns;
		
		addr<="01";
		wait for 100 ns;
		
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
