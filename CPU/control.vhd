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
   IRreq :in STD_LOGIC;                          --irʹ��
   IR:out  STD_LOGIC_VECTOR (15 downto 0);       --��ȡָģ�����ir
   PCout: in  STD_LOGIC_VECTOR (15 downto 0);    --����ȡָָ��
   
   ALUOUT : in  STD_LOGIC_VECTOR (7 downto 0);   --����ģ��
   Addr : in  STD_LOGIC_VECTOR (15 downto 0);    --����ģ��
   
   ABUS : out  STD_LOGIC_VECTOR (15 downto 0);   --�����������ַ 
   DBUS : inout  STD_LOGIC_VECTOR (15 downto 0); --��������

   --�����淢
   nWR : out  STD_LOGIC;                          --д����ʹ��
   nRD : out  STD_LOGIC;                          --������ʹ��
   nMREQ : out  STD_LOGIC;                       --����Ƭѡ�ź�
   nBHE : out  STD_LOGIC;                        --����߰�λ�����ź�
   nBLE : out  STD_LOGIC;                         --����Ͱ�λ�����ź�
   --����ģ��/ȡָģ�������Ҫ��Ҫ���ڴ�
   nMWR : in  STD_LOGIC;                          --ALUд��ʹ��
   nMRD : in  STD_LOGIC;                          --ALUȡ��ʹ��
   --���Դ洢ģ��
   data : out  STD_LOGIC_VECTOR (7 downto 0)     --�Դ洢�������ȡ�������ݡ�
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
      if (IRreq ='1' and nMRD = '1' and nMWR = '1') then   --ȡָģ��
			nBHE <= '0';
			nBLE <= '0';--�ߵ�λ		
			nMREQ <= '0';
			nWR <= '1';
			nRD <= '0';--����Ч���͵�λ��Ч
			IR <= DBUS;	
         --DBUS<="ZZZZZZZZZZZZZZZZ";	
			ABUS<=PCout;		
		elsif (nMRD = '0' and IRreq ='0' and nMWR = '1') then --��Ҫ���ڴ�(����ģ��)---��ȡʹ�ܣ��͵�ƽ��Ч
			nBHE <= '1';
			nBLE <= '0';
			nMREQ <= '0';
			nRD <= '0';	--?����?
			nWR <= '1';
			ABUS <= Addr;
			--data <= "00100101";
			data<=DBUS(7 downto 0);	
			--DBUS<="ZZZZZZZZZZZZZZZZ";	
		elsif (nMWR = '0' and IRreq ='0' and nMRD = '1') then --д�ڴ�(����ģ��)
		   nBHE <= '1';
		   nBLE <= '0';
		   nMREQ <= '0';
		   nRD <= '1';	
		   nWR <= '0';--д��Ч
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