----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:24:12 07/09/2015 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           Cin : in  STD_LOGIC;
           Card : in  STD_LOGIC_VECTOR (4 downto 0);
           F : out  STD_LOGIC_VECTOR (7 downto 0);
           Cout : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
	signal A1,B1,P : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
begin
	A1(7 downto 0) <= A;
	B1(7 downto 0) <= B;
	
	WITH Card SELECT
	P <= 
		A1+B1 WHEN "00000",                  ---A+B
		A1+B1+Cin WHEN "00001",              ---A+B+Cin
		A1-B1 WHEN "00010",                  ---A-B
		A1-B1-Cin WHEN "00011",              ---A-B-Cin
		B1-A1 WHEN "00100",                  ---B-A
		B1-A1-Cin WHEN "00101",              ---B-A-Cin
		A1 WHEN "00110",                     ---A
		B1 WHEN "00111",                     ---B
		NOT A1 WHEN "01000",                 ---/A
		NOT B1 WHEN "01001",                 ---/B
		A1 or B1 WHEN "01010",                  ---A+B
		A1 and B1 WHEN "01011",                  ---A*B
		A1 XNOR B1 WHEN "01100",             ---A xnor B
		A1 XOR B1 WHEN "01101",              ---A xor B
		NOT(A1 and B1) WHEN "01110",           ---not (A * B)
		"000000000" WHEN "01111",            ---0
		"ZZZZZZZZZ" WHEN OTHERS;             ---others
	F <= P(7 downto 0);
	Cout <= P(8);
end Behavioral;

