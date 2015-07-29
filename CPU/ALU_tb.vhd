--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:37:32 07/10/2014
-- Design Name:   
-- Module Name:   
-- Project Name:  CPU_1st_edition
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         enable_t : IN  std_logic;
			ir : IN std_logic_vector(15 downto 0);
         sig_reg7aluout : OUT  std_logic_vector(15 downto 0);
         sig_reg7addrout : OUT  std_logic_vector(15 downto 0);
         enable_wb : IN  std_logic;
         reg_wb : IN  std_logic_vector(7 downto 0);
         cy : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal enable_t : std_logic := '0';
	signal ir : std_logic_vector(15 downto 0) := (others => '0');
   signal enable_wb : std_logic := '0';
   signal reg_wb : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal sig_reg7aluout : std_logic_vector(15 downto 0);
   signal sig_reg7addrout : std_logic_vector(15 downto 0);
   signal cy : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          enable_t => enable_t,
			 ir => ir,
          sig_reg7aluout => sig_reg7aluout,
          sig_reg7addrout => sig_reg7addrout,
          enable_wb => enable_wb,
          reg_wb => reg_wb,
          cy => cy
        );

   -- Stimulus process
   stim_proc: process
   begin		
		-- 测试回写模
		ir <= "0000011100000000";
		reg_wb <= "00000000";
		enable_wb <= '0';
		wait for 20 ns;
		enable_wb <= '1';
		wait for 20 ns;
		
		
		ir <= "0000011000000000";
		reg_wb <= "11111111";
		enable_wb <= '0';
		wait for 20 ns;
		enable_wb <= '1';
		wait for 20 ns;
      
		
		ir <= "0000010100000000";
		reg_wb <= "11111111";
		enable_wb <= '0';
		wait for 20 ns;
		enable_wb <= '1';
		wait for 20 ns;
		
		
		ir <= "0000010000000000";
		reg_wb <= "01000100";
		enable_wb <= '0';
		wait for 20 ns;
		enable_wb <= '1';
		wait for 20 ns;
		
		
		ir <= "0000001100000000";
		reg_wb <= "00110011";
		enable_wb <= '0';
		wait for 20 ns;
		enable_wb <= '1';
		wait for 20 ns;
		
		
		ir <= "0000001000000000";
		reg_wb <= "00100010";
		enable_wb <= '0';
		wait for 20 ns;
		enable_wb <= '1';
		wait for 20 ns;
		
		
		ir <= "0000000100000000";
		reg_wb <= "00010001";
		enable_wb <= '0';
		wait for 20 ns;
		enable_wb <= '1';
		wait for 20 ns;
		
		
		ir <= "0000000000000000";
		reg_wb <= "00000000";
		enable_wb <= '0';
		wait for 20 ns;
		enable_wb <= '1';
		wait for 20 ns;
		enable_wb <= '0';
		
		-- 测试操作码，同时测试进位标志		
		--ADD
		ir <= "0000011000000110";
		enable_t <= '0';
		wait for 20 ns ;
		enable_t <= '1';
		wait for 20 ns ;
		enable_t <= '0' ;
		wait for 20 ns;
		
		--SUB
		ir <= "0000111000000001";
		enable_t <= '0';
		wait for 20 ns ;
		enable_t <= '1';
		wait for 20 ns ;
		enable_t <= '0' ;
		wait for 20 ns;
		
		--MOV
		ir <= "0001010100000001";
		enable_t <= '0';
		wait for 20 ns ;
		enable_t <= '1';
		wait for 20 ns ;
		enable_t <= '0' ;
		wait for 20 ns;
		
		--MVI
		ir <= "1001011010101010";
		enable_t <= '0';
		wait for 20 ns ;
		enable_t <= '1';
		wait for 20 ns ;
		enable_t <= '0' ;
		wait for 20 ns;
		
		--LDA
		ir <= "1101100010101010";
		enable_t <= '0';
		wait for 20 ns ;
		enable_t <= '1';
		wait for 20 ns ;
		enable_t <= '0' ;
		wait for 20 ns;
		
		--STA
		ir <= "1100011010101010";
		enable_t <= '0';
		wait for 20 ns ;
		enable_t <= '1';
		wait for 20 ns ;
		enable_t <= '0' ;
		wait for 20 ns;
		
		--JMP
		ir <= "1000111010101010";
		enable_t <= '0';
		wait for 20 ns ;
		enable_t <= '1';
		wait for 20 ns ;
		enable_t <= '0' ;
		wait for 20 ns;
		
		--JZ
		ir <= "1000011010101010";
		enable_t <= '0';
		wait for 20 ns ;
		enable_t <= '1';
		wait for 20 ns ;
		enable_t <= '0' ;
		wait for 20 ns;
		
      wait;
   end process;

END;
