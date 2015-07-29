----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:46:08 07/26/2015 
-- Design Name: 
-- Module Name:    ALU_module - Behavioral 
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

entity ALU is
port(
	   -- ʵ��׼�������㹦��
	  enable_t : in std_logic ; -- ׼�������㹦��ʹ���ź�
	  ir : in std_logic_vector(15 downto 0);
	  
	  -- ��ô����ģ�����
	  sig_reg7aluout : out std_logic_vector ( 15 downto 0 ); -- �ݴ�������˿�
	  sig_reg7addrout : out std_logic_vector ( 15 downto 0 ); -- 8λ��ַ����˿�
	  --reg7_out : out std_logic_vector ( 7 downto 0 );
	  
	  -- ʵ�ֻ�д����
	  enable_wb : in std_logic ; -- ��д����ʹ��
	  reg_wb : in std_logic_vector (7 downto 0 );  -- ��д���ն˿�
	  
	  -- ��λ��־
	  cy : out std_logic 
	  );
	  
end ALU;

architecture Behavioral of ALU is

type registers_8 is array (7 downto 0) of std_logic_vector(7 downto 0);
signal reg : registers_8; -- ������8��8λ�Ĵ���
signal addr : std_logic_vector ( 7 downto 0 ); -- �ݴ���
begin
get_ready : process (enable_t,addr)
variable a,b : std_logic_vector ( 7 downto 0 );
variable tempa , tempb ,tempsum: std_logic_vector (8 downto 0 ); -- ��λ��־����

begin
a := reg(conv_integer(ir(10 downto 8)));
b := reg(conv_integer(ir(2 downto 0)));
addr <= ir( 7 downto 0 );
tempa := '0'&a;
tempb := '0'&b;
	if enable_t = '1'  then
		case ir(15 downto 11) is
			when "00000"=>  tempsum := tempa + tempb ;         --ADD
			when "00001"=>	 tempsum := tempa - tempb ;         --SUB
			when "00010"=>	 tempsum := tempb;                  --MOV
			when "10010"=>  tempsum	:= '0'&addr;               --MVI
			when "11011"=>	 tempsum := '0'&addr;               --LDA
			when "11000"=>	 tempsum := tempa;                  --STA
			when "10001"=>	 tempsum := '0'&addr;               --JMP
			when "10000"=>  tempsum := tempa;                  --JZ
			--when "11111"=>  tempsum := '0'&addr;               --IN
			--when "11100"=>  tempsum :=tempa;                   --OUT
			when others=>	 tempsum :="ZZZZZZZZZ";
		end case;
	sig_reg7aluout <= reg(7)&tempsum ( 7 downto 0 );
	cy <= tempsum (8) ;
	sig_reg7addrout <= reg(7)&addr;
	end if ;
end process;

write_back : process (reg_wb,enable_wb)
begin
	if enable_wb = '1' then
		reg(conv_integer(ir(10 downto 8))) <= reg_wb;
	end if;
end process;

end Behavioral;

