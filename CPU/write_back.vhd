----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:34:39 07/28/2015 
-- Design Name: 
-- Module Name:    write_back - Behavioral 
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

entity write_back is
Port (
    PCin:in std_logic_vector(15 downto 0);            --接收取指模块传出的PC，用于0跳转和直接跳转
    t : in  STD_LOGIC;                                -- 回写使能
	 Rtemp : in  STD_LOGIC_VECTOR (7 downto 0);        -- 接收来自存储管理模块的寄存器
    IR : in  STD_LOGIC_VECTOR (15 downto 0);          -- 接收取指模块传出的IR
	 --z:in STD_LOGIC;                                   --接收ALU传出的z
	 cy:in STD_LOGIC;                                  --接收ALU传出的进位
    Rupdate : out  STD_LOGIC;                         -- 寄存器回写使能信号
	 Rdata : out  STD_LOGIC_VECTOR (7 downto 0);       -- ALU 输出的寄存器回写数据
	 PCupdate : out  STD_LOGIC;                        -- PC 回写使能型号
    PCnew : out  STD_LOGIC_VECTOR (15 downto 0)       --输出PC回写的值
);
end write_back;

architecture Behavioral of write_back is
--signal tempa:std_logic_vector(15 downto 0);
--signal tempb:std_logic_vector(15 downto 0);
begin 
  -- tempa<="00000000"&(IR(7 downto 0));
	process(t, cy, IR)
	begin 
		if t='1' then 
			case IR(15 downto 11) is 
				when "10001" =>
					Rupdate <= '0';  --jmp 
				   PCupdate <= '1';
				   PCnew <= "00000000"&(IR(7 downto 0));
				when "10000" =>     --jz
					Rupdate <= '0';
					if (Rtemp(7 downto 0) = "00000000") then
					--if  z='1' then
						PCnew <= "00000000"&(IR(7 downto 0));
						PCupdate <= '1';
               else
						PCupdate<='0';										 
				   end if;	
				when "11000" =>null;--STA
			 	when others =>
					Rupdate<='1';
				   PCupdate <= '0';
					Rdata(7 downto 0)<= Rtemp(7 downto 0);
			end case;
      else PCupdate<='0';Rupdate<='0';
      end if;
	end process;
end Behavioral;

