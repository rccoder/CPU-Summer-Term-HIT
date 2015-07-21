----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:24:59 07/20/2015 
-- Design Name: 
-- Module Name:    fpgaclk - Behavioral 
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

entity fpgaclk is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           A : out  STD_LOGIC_VECTOR (3 downto 0));
end fpgaclk;

architecture Behavioral of fpgaclk is

begin
process(clk, reset)

variable q:std_logic_vector(3 downto 0);
begin
if(reset = '0') then
	A <= "0001";
	q := "0001";
	elsif(clk = '1' and clk'event) then
	case q is
	when "0001" => A <= "0010";
	q := "0010";
	when "0010" => A <= "0100";
	q := "0100";
	when "0100" => A <= "1000";
	q := "1000";
	when "1000" => A <= "0001";
	q := "0001";
	when others => A <= "0001";
	q := "0001";
	end case;
	end if;
	end process;

end Behavioral;

