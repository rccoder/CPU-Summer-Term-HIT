----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:40:19 07/28/2015 
-- Design Name: 
-- Module Name:    save - Behavioral 
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

entity save is
    Port ( 
		 t : in  STD_LOGIC;
		 ALUOUT : in std_logic_vector(7 downto 0);      --- 取数的时候用
		 data : in std_logic_vector(7 downto 0);       --- 接收区属的时候访存控制的数据
		 nMWR : out std_logic;                         
       IR : in  STD_LOGIC_VECTOR (15 downto 0);
       nMRD : out  STD_LOGIC;
		 Rtemp : out std_logic_vector(7 downto 0));    --- 回写模块要输
end save;
 
architecture Behavioral of save is
begin 
	process(t,data,ALUOUT,IR)
	begin 
		if t = '1' then -- LDA与STA
			case IR(14 downto 12) is
				when "100" =>           --- STA   存数 11000
					nMWR <= '0';
					nMRD <= '1';
					Rtemp(7 downto 0) <= ALUOUT(7 downto 0);
				when "101" =>           --- LDA    取数  11011
					nMWR <= '1';
					nMRD <= '0';
					Rtemp(7 downto 0) <= data(7 downto 0);
				when others => 
					nMWR <= '1';
					nMRD <= '1';
					Rtemp(7 downto 0) <= ALUOUT(7 downto 0);
			end case;
		else
			nMWR <= '1';
			nMRD <= '1';
			
		end if;
		
	end process;	
end Behavioral;