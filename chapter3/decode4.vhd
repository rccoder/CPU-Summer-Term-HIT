----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:45:16 07/16/2015 
-- Design Name: 
-- Module Name:    decode4 - Behavioral 
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

entity decode4 is
port(
	d : in std_logic_vector(3 downto 0);
	enable : in std_logic;
	q8, q9, q11 : out std_logic
	);
end decode4 ;

architecture main of decode4 is
begin
	process( enable, d )
	begin
		if enable = '1' then
			case d is
				when "1000" =>  q8 <= '0'; q9 <= '1'; q11 <= '1';
				when "1001" =>  q8 <= '1'; q9 <= '0'; q11 <= '1';
				when "1011" =>  q8 <= '1'; q9 <= '1'; q11 <= '0';
				when others =>	q8 <= '1'; q9 <= '1'; q11 <= '1';
			end case;
		else
			q8 <= '1'; q9 <= '1'; q11 <= '1';
		end if;
	end process;
end main;


