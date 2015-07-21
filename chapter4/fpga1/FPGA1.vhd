----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:10:39 07/20/2015 
-- Design Name: 
-- Module Name:    FPGA1 - Behavioral 
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

entity FPGA1 is
    Port ( k5 : in  STD_LOGIC_VECTOR (7 downto 0);
           k6 : in  STD_LOGIC_VECTOR (7 downto 0);
           s0 : out  STD_LOGIC_VECTOR (7 downto 0);
           s1 : out  STD_LOGIC_VECTOR (7 downto 0);
           B : out  STD_LOGIC_VECTOR (7 downto 0));
end FPGA1;

architecture Behavioral of FPGA1 is

begin
process(k5, k6)
begin
s0 <= k5;
s1 <= k5;
B <= k6;
end process;

end Behavioral;

