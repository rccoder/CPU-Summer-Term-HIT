--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:05:02 07/30/2015
-- Design Name:   
-- Module Name:   C:/Users/rccoder/ALU/CPU/CPU_tb.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU
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
 
ENTITY CPU_tb IS
END CPU_tb;
 
ARCHITECTURE behavior OF CPU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU
    PORT(
         RST : IN  std_logic;
         CLK : IN  std_logic;
         ABUS : OUT  std_logic_vector(15 downto 0);
         DBUS : INOUT  std_logic_vector(15 downto 0);
         nMREQ : OUT  std_logic;
         nRD : OUT  std_logic;
         nWR : OUT  std_logic;
         nBHE : OUT  std_logic;
         nBLE : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

	--BiDirs
   signal DBUS : std_logic_vector(15 downto 0);

 	--Outputs
   signal ABUS : std_logic_vector(15 downto 0);
   signal nMREQ : std_logic;
   signal nRD : std_logic;
   signal nWR : std_logic;
   signal nBHE : std_logic;
   signal nBLE : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU PORT MAP (
          RST => RST,
          CLK => CLK,
          ABUS => ABUS,
          DBUS => DBUS,
          nMREQ => nMREQ,
          nRD => nRD,
          nWR => nWR,
          nBHE => nBHE,
          nBLE => nBLE
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		--¸´Î»
		RST <= '1';
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		
      wait for 10 ns;
		RST <= '0';
		wait for 5 ns;	
		DBUS <= "1001011100000010";	            	--- MVI R7  00000000     9710 
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;

		DBUS <= "1100011110000000";                 --- STA R7 80h     c780
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "1001011000000010";                --- MVI R6  00000010       9600
      wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;

		DBUS <= "1100011010000001";                 --- STA R6    81h      c681
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "1001010100000100";                 --- MVI R5  00000100  9504
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "1100010110000010";                 --- STA R5  82h        c582
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "1001010000001000";                 --- MVI¡¡R4 00001000    9408
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "1100010010000011";                 --- STA R4 83h         c483
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "1001001100010000";                 --- MVI R3  00010000     9310
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;

		DBUS <= "1100001110000100";                 --- STA R3 84h        c384
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "1001001000100000";                 --- MVI R2  00100000     9220
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;

		DBUS <= "1100001010000101";                 --- STA R2 85h      c285
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "1001000101000000";                 ---MVI R1   01000000    9140
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;

		DBUS <= "1100000110000110";                 --- STA R1 86h        c186
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "1001000011111111";                 --- MVI R0 11111111       90ff
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;

		DBUS <= "1100000010000111";                 --- STA R0 87h         c087
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "0000000000000110";                 --- ADD R0  R6   11111111 + 10   0006
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;

		DBUS <= "1100000010001000";                 --- STA R0 88h        00000000 cy 1   c088
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "0000110000000101";                 --- SUB R4 R5         0c05
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;

		DBUS <= "1100010010001001";                 --- STA R4 89h            00000100    1000-0100    c489 
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <=  "0001011000000100";                --- MOV R6 R4        1604
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;

		DBUS <= "1100011010010000";                 --- STA R6 90h         0100   c690
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "1101110110001001";                --- LDA R5 10001001      89h   r4    dd89
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		DBUS <= "0000000011111111";
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 10 ns;
		
		DBUS <= "1100010110010001";                 --- STA R5 91h   11111111    c591
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;

		DBUS <= "1100011110010010";                --STA  R7 92h            c792
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "1000001000110000";                -- JZ R2 00001000     8230
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;

		DBUS <= "1001001000000000";                -- MVI R2 00000000   9200
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;

		DBUS <= "1100001010010011";                --STA  R2 93h    c293
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
		DBUS <= "1000001000110000";                -- JZ R2 00010000    8230
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;

		DBUS <= "1000100000110101";                -- JMP  00000100   8835  
		wait for 10 ns;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		
      -- insert stimulus here 

      wait;
   end process;

END;
