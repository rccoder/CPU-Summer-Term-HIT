----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:30:30 07/20/2015 
-- Design Name: 
-- Module Name:    FPGA0 - Behavioral 
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

entity FPGA0 is
    Port ( k0 : in  STD_LOGIC_VECTOR (7 downto 0);
           k1 : in  STD_LOGIC_VECTOR (7 downto 0);
           k2 : in  STD_LOGIC_VECTOR (7 downto 0);
           k3 : in  STD_LOGIC_VECTOR (7 downto 0);
           k4 : in  STD_LOGIC_VECTOR (7 downto 0);
           s0 : out  STD_LOGIC_VECTOR (7 downto 0);
           s1 : out  STD_LOGIC_VECTOR (7 downto 0);
           s2 : out  STD_LOGIC_VECTOR (7 downto 0);
           s3 : out  STD_LOGIC_VECTOR (7 downto 0);
           s4 : out  STD_LOGIC_VECTOR (7 downto 0);
           s5 : out  STD_LOGIC_VECTOR (7 downto 0);
           A : out  STD_LOGIC_VECTOR (7 downto 0);
           B : out  STD_LOGIC_VECTOR (7 downto 0));
end FPGA0;

architecture Behavioral of FPGA0 is

begin
process(k0, k1, k2, k3, k4)
begin
s0 <= k0;
s3 <= k0;
s1 <= k1;
s4 <= k1;
s2 <= k2;
s5 <= k2;
B <= k3;
A <= k4;
end process;
end Behavioral;

