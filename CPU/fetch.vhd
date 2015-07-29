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
    Port ( irnew : in  STD_LOGIC_VECTOR (15 downto 0);        --�ô�ģ�������IR
           pcnew : in  STD_LOGIC_VECTOR (15 downto 0);        --��дģ�飬����PC
           clk : in  STD_LOGIC;                               --����
           pcupdate : in  STD_LOGIC;                          --����Ҫ����PC��
           reset : in  STD_LOGIC;                             --��λ
           t0 : in  STD_LOGIC;
           t1 : in  STD_LOGIC;
           irout : out  STD_LOGIC_VECTOR (15 downto 0);        --�����IR
           pcout : out  STD_LOGIC_VECTOR (15 downto 0);
           irrep : out  STD_LOGIC);                            --ʹ��
end fetch;

architecture Behavioral of fetch is
signal pc : STD_LOGIC_VECTOR (15 downto 0);
begin
	process(clk, reset, t0, t1, pcupdate)
		begin
			if reset = '1' then
				irrep <= '0';
				pc <= "0000000000000000";
			elsif t0 = '1' then
				irrep <= '1';
				irout <= irnew;
			elsif t1 = '1' then
				irrep <= '0';
				if (clk = '1' and clk' event) then
					pc <= pc + 1;
				end if;
			elsif pcupdate = '1' then
				pc <= pcnew;
				irrep <= '0';
			
			end if;
			pcout <= pc;
	end process;
end Behavioral;

