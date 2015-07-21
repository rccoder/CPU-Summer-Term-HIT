----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:03:31 07/13/2015 
-- Design Name: 
-- Module Name:    fpgamemory - Behavioral 
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

entity fpgamemory is
    Port ( k0 : in  STD_LOGIC_VECTOR (7 downto 0);
           k1 : in  STD_LOGIC_VECTOR (7 downto 0);
           k2 : in  STD_LOGIC_VECTOR (7 downto 0);
           k3 : in  STD_LOGIC_VECTOR (7 downto 0);
           k4 : in  STD_LOGIC_VECTOR (7 downto 0);
           addr : inout  STD_LOGIC_VECTOR (15 downto 0);
           datain : inout  STD_LOGIC_VECTOR (15 downto 0);
           cs : out  STD_LOGIC;
           wr : out  STD_LOGIC;
           rd : out  STD_LOGIC;
           bh : out  STD_LOGIC;
           bl : out  STD_LOGIC;
			  s0 : out std_logic_vector(7 downto 0);
			  s1 : out std_logic_vector(7 downto 0));
end fpgamemory;

architecture Behavioral of fpgamemory is

begin
addr<=k3&k2;
cs<=k4(1);
wr<=k4(4);
rd<=k4(0);
bh<=k4(2);
bl<=k4(3);
write_process:process(k0,k1,k2,k3,k4)
begin
if k4(1) = '0' and k4(0) = '1' and k4(4)='0' and k4(3) = '0' and k4(2) = '0' then
	datain(7 downto 0) <=k0;
	datain(15 downto 8)<=k1;
elsif k4(1) = '0' and k4(0) = '1' and k4(3) = '0' and k4(4)='0' and k4(2) = '1' then
	datain(7 downto 0)<=k0;
	datain(15 downto 8)<= "ZZZZZZZZ";
elsif k4(1) = '0' and k4(0) = '1' and k4(3) = '1' and k4(4)='0' and k4(2) = '0' then
	datain(7 downto 0)<="ZZZZZZZZ";
	datain(15 downto 8)<=k1;
else
	datain<="ZZZZZZZZZZZZZZZZ";
end if;
end process write_process;

read_process:process(k0,k1,k2,k3,k4)
begin
if k4(1) = '0' and k4(0) = '0' and k4(4)='1' and k4(3) = '0' and k4(2) = '0' then
	s0 <= datain(7 downto 0);
	s1 <= datain(15 downto 8);
elsif k4(1) = '0' and k4(0) = '0' and k4(3) = '0' and k4(4)='1' and k4(2) = '1' then
	s0 <= datain(7 downto 0);
	s1 <= "ZZZZZZZZ";
elsif k4(1) = '0' and k4(0) = '0' and k4(3) = '1' and k4(4)='1' and k4(2) = '0' then
	s0 <= "ZZZZZZZZ";
	s1 <= datain(15 downto 8);
else
	s0<="ZZZZZZZZ";
	s1<="ZZZZZZZZ";
end if;
end process read_process;

end Behavioral;

