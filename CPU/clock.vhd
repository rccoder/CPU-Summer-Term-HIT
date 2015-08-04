----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:37:09 07/24/2015 
-- Design Name: 
-- Module Name:    clock - Behavioral 
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

entity clock is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           t : out  STD_LOGIC_VECTOR (4 downto 0));
end clock;

architecture Behavioral of clock is
begin
	process(clk, reset)
	variable tep : integer range 0 to 6 := 0;
	begin
		if(reset = '1') then
			t <= "00000";
			tep := 0;
		elsif (clk = '1' and clk' event) then
			tep := tep + 1;
			if tep = 6 then
				tep := 1;
			end if;
			case tep is
				when 1 => t <= "00001";
				when 2 => t <= "00010";
				when 3 => t <= "00100";
				when 4 => t <= "01000";
				when 5 => t <= "10000";
				when others => NULL;
			end case;
		end if;
	end process;
end Behavioral;