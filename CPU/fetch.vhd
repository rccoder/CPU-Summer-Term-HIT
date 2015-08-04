----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:02:49 07/24/2015 
-- Design Name: 
-- Module Name:    fetch - Behavioral 
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fetch is
    Port ( irnew : in  STD_LOGIC_VECTOR (15 downto 0);        --访存模块输入的IR
           pcnew : in  STD_LOGIC_VECTOR (15 downto 0);        --?匦茨？?，?翽C
           clk : in  STD_LOGIC;                               --节拍
           pcupdate : in  STD_LOGIC;                          --告诉要更新PC了
           reset : in  STD_LOGIC;                             --复位
           t0 : in  STD_LOGIC;
           t1 : in  STD_LOGIC;
           irout : out  STD_LOGIC_VECTOR (15 downto 0);        --输出的IR
           pcout : out  STD_LOGIC_VECTOR (15 downto 0);
           irrep : out  STD_LOGIC);                            --使能
end fetch;

architecture Behavioral of fetch is
signal pc : STD_LOGIC_VECTOR (15 downto 0);
begin
--	process(clk, reset, t0, t1, pcupdate)
--		begin
--			if reset = '1' then
--				irrep <= '0';
--				pc <= "0000000000000000";
--			elsif t0 = '1' then
--				irrep <= '1';
--				irout <= irnew;
--			elsif t1 = '1' then
--				irrep <= '0';
--				if (clk = '1' and clk' event) then
--					pc <= pc + 1;
--				end if;
--			elsif pcupdate = '1' then
--				pc <= pcnew;
--				irrep <= '0';
--			
--			end if;
--			pcout <= pc;
--	end process;
	
	process(clk, reset, pcupdate, t1, t0)
		begin
			if reset = '1' then
				pc <= "0000000000000000";
			elsif pcupdate = '1' then
				pc <= pcnew;
			elsif t1 = '1' and clk = '1' and clk' event then
				pc <= pc + 1;
			end if;
			pcout <= pc;
	end process;
	
	process(clk, t0, t1)
	begin
		if t0 = '1' then
			irrep <= '1';
			irout <= irnew;
		elsif t1 <= '1' then
			irrep <= '0';
		end if;
	end process;
	
	
end Behavioral;

