----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:40:58 07/27/2015 
-- Design Name: 
-- Module Name:    cccccccccc - Behavioral 
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
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;



entity control is
port(
   IRreq :in STD_LOGIC;                          --ir使能
   IR:out  STD_LOGIC_VECTOR (15 downto 0);       --对取指模块输出ir
   PCout: in  STD_LOGIC_VECTOR (15 downto 0);    --接收取指指令
   
   ALUOUT : in  STD_LOGIC_VECTOR (7 downto 0);   --运算模块
   Addr : in  STD_LOGIC_VECTOR (15 downto 0);    --运算模块
   
   ABUS : out  STD_LOGIC_VECTOR (15 downto 0);   --对主存输出地址 
   DBUS : inout  STD_LOGIC_VECTOR (15 downto 0); --数据总线

   --给主存发
   nWR : out  STD_LOGIC;                          --写主存使能
   nRD : out  STD_LOGIC;                          --读主存使能
   nMREQ : out  STD_LOGIC;                       --主存片选信号
   nBHE : out  STD_LOGIC;                        --主存高八位控制信号
   nBLE : out  STD_LOGIC;                         --主存低八位控制信号
   --运算模块/取指模块给出，要不要访内存
   nMWR : in  STD_LOGIC;                          --ALU写数使能
   nMRD : in  STD_LOGIC;                          --ALU取数使能
   --来自存储模块
   data : out  STD_LOGIC_VECTOR (7 downto 0)     --对存储控制输出取到的数据。
);
end control;
architecture Behavioral of control is

begin 	
   --IR <= DBUS;		  
	--DBUS<="00000000"&ALUOUT when nMWR='0' else "ZZZZZZZZZZZZZZZZ";
	--data <= DBUS(7 downto 0) when nMRD = '0' else "ZZZZZZZZ";
	--ABUS<=PCout when IRreq='1' else Addr; 
process(IRreq,nMRD,nMWR)
	begin 
		DBUS<="ZZZZZZZZZZZZZZZZ";
      if (IRreq ='1' and nMRD = '1' and nMWR = '1') then   --取指模块
			nBHE <= '0';
			nBLE <= '0';--高低位		
			nMREQ <= '0';
			nWR <= '1';
			nRD <= '0';--读有效，低电位有效
			IR <= DBUS;	
         --DBUS<="ZZZZZZZZZZZZZZZZ";	
			ABUS<=PCout;		
		elsif (nMRD = '0' and IRreq ='0' and nMWR = '1') then --需要读内存(运算模块)---读取使能，低电平有效
			nBHE <= '1';
			nBLE <= '0';
			nMREQ <= '0';
			nRD <= '0';	--?劣行?
			nWR <= '1';
			ABUS <= Addr;
			--data <= "00100101";
			data<=DBUS(7 downto 0);	
			--DBUS<="ZZZZZZZZZZZZZZZZ";	
		elsif (nMWR = '0' and IRreq ='0' and nMRD = '1') then --写内存(运算模块)
		   nBHE <= '1';
		   nBLE <= '0';
		   nMREQ <= '0';
		   nRD <= '1';	
		   nWR <= '0';--写有效
			DBUS<="00000000"&ALUOUT;
			ABUS<=Addr; 
		else 	 
		   nBHE <= '1';
		   nBLE <= '1';
		   nMREQ <= '1';
		   nRD <= '1';	
		   nWR <= '1';
			data<="ZZZZZZZZ";
			DBUS<="ZZZZZZZZZZZZZZZZ";	
	end if;
end process;
end Behavioral;