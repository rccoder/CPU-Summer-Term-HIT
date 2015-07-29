----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:46:56 07/16/2015 
-- Design Name: 
-- Module Name:    sreg - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sreg is
port(
	clk, clrn, serial : in std_logic;
	q : out std_logic_vector(7 downto 0)
	);
end sreg ;

architecture main of sreg is
	signal t : std_logic_vector(7 downto 0);
begin
	process(clk, clrn)
	begin
		if clrn = '0' then
			t <= "00000000";
		elsif clk = '1' and clk'event then 
			t(7) <= serial;
			t(6 downto 0) <= t(7 downto 1);
		end if;
q <= t;
	end process;
end main;

