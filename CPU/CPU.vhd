----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:57:22 07/29/2015 
-- Design Name: 
-- Module Name:    CPU - Behavioral 
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

entity CPU is
    Port ( RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           ABUS : in  STD_LOGIC_VECTOR (15 downto 0);
           DBUS : in  STD_LOGIC_VECTOR (15 downto 0);
           nMREQ : in  STD_LOGIC;
           nRD : in  STD_LOGIC;
           nWR : in  STD_LOGIC;
           nBHE : in  STD_LOGIC;
           nBLE : in  STD_LOGIC);
end CPU;

architecture Behavioral of CPU is
	component clock is
		port (
			clk : in  STD_LOGIC;
         reset : in  STD_LOGIC;
         t : out  STD_LOGIC_VECTOR (4 downto 0)
		);
	end component;
	
	component fetch is
		port (
			irnew : in  STD_LOGIC_VECTOR (15 downto 0);        --�ô�ģ�������IR
         pcnew : in  STD_LOGIC_VECTOR (15 downto 0);        --��дģ�飬����PC
         clk : in  STD_LOGIC;                               --����
         pcupdate : in  STD_LOGIC;                          --����Ҫ����PC��
         reset : in  STD_LOGIC;                             --��λ
         t0 : in  STD_LOGIC;
         t1 : in  STD_LOGIC;
         irout : out  STD_LOGIC_VECTOR (15 downto 0);        --�����IR
         pcout : out  STD_LOGIC_VECTOR (15 downto 0);
         irrep : out  STD_LOGIC
		);
	end component;
	
	component ALU is
		port (
		   -- ʵ��׼�������㹦��
		   enable_t : in std_logic; -- ׼�������㹦��ʹ���ź�
			ir : in std_logic_vector(15 downto 0);   --16λ��IR�ź�
	  
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
	end component;
	
	component control is
		port (
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
	end component;
	
	component save is
		port (
			t : in  STD_LOGIC;
			ALUOUT : in std_logic_vector(7 downto 0);     --- ALU�����ֵ
			data : in std_logic_vector(7 downto 0);       --- ����������ʱ��ô���Ƶ�����
			nMWR : out std_logic;                         
			IR : in  STD_LOGIC_VECTOR (15 downto 0);
			nMRD : out  STD_LOGIC;
			Rtemp : out std_logic_vector(7 downto 0)
		);                                  
	end component;
	
	component write_back is
		port (
			PCin:in std_logic_vector(15 downto 0);            --����ȡָģ�鴫����PC������0��ת��ֱ����ת
			t : in  STD_LOGIC;                                -- ��дʹ��
			Rtemp : in  STD_LOGIC_VECTOR (7 downto 0);        -- �������Դ洢����ģ��ļĴ���
			IR : in  STD_LOGIC_VECTOR (15 downto 0);          -- ����ȡָģ�鴫����IR
			z:in STD_LOGIC;                                   --����ALU������z
			cy:in STD_LOGIC;                                  --����ALU�����Ľ�λ
			Rupdate : out  STD_LOGIC;                         -- �Ĵ�����дʹ���ź�
			Rdata : out  STD_LOGIC_VECTOR (7 downto 0);       -- ALU ����ļĴ�����д����
			PCupdate : out  STD_LOGIC;                        -- PC ��дʹ���ͺ�
			PCnew : out  STD_LOGIC_VECTOR (15 downto 0)       --���PC��д��ֵ
		);
	end component;
	
signal t : STD_LOGIC_VECTOR(4 downto 0);      --��������   
signal IR_C_F : STD_LOGIC_VECTOR(15 downto 0);  --  ȡָģ��ȡ����ir
signal PCout_F_CW : STD_LOGIC_VECTOR(15 downto 0);  -- PC �����ô����ȡָ���ͻ�дģ��
signal PCnew_W_F : STD_LOGIC_VECTOR(15 downto 0);    -- ��ת��ʱ��Ҫ���µ�PC
signal PCupdate_W_F : STD_LOGIC;                    -- ��ת����PCʹ���ź�
signal irout_F_ASW : STD_LOGIC_VECTOR(15 downto 0);  --ȡָģ��ȡ����Ir,������ALU �洢 �ͻ�д
signal irreq_F_C : STD_LOGIC;                 -- ȡָ�����ô���ƣ�����Ҫȡָ����
signal ALUOUT_A_CS : STD_LOGIC_VECTOR(15 downto 0);    ---ALU ��������ģ���aluout
signal Addr_A_C : STD_LOGIC_VECTOR(15 downto 0);      --- ALU �����ô��addr
signal Rupdate_W_A : STD_LOGIC;                         ---��дģ������ALU�ĸ��ļĴ���ʹ���ź�
signal Rdata_W_A : STD_LOGIC_VECTOR(15 downto 0);         ----��дģ�������Ҫ���µļĴ�����ֵ
signal data_C_S : STD_LOGIC_VECTOR(7 downto 0);           -- ȡ����ʱ��ʹ��
signal nMWR_S_C : STD_LOGIC;                              --д��ʹ��
signal nMRD_S_C : STD_LOGIC;                              --����ʹ��
signal Rtemp_S_W : STD_LOGIC_VECTOR(7 downto 0);          -- �洢ģ�����дģ��
signal cy_A_W : STD_LOGIC;                                --��λ
begin
	
	clock: clock port map(CLK, RST, t);
	fetch: fetch port map(IR_C_F, PCnew_W_F, CLK , PCupdate_W_F, RST, t(0), t(1), irout_F_ASW, PCout_F_CW, irreq_F_C);
	ALU: ALU port map(t(2), irout_F_ASW, ALUOUT_A_CS, Addr_A_C, Rupdate_W_A, Rdata_W_A, cy_A_W);
	control: control port map(irreq_F_C, IR_C_F, PCout_F_CW, ALUOUT_A_CS(7 downto 0), Addr_A_C, ABUS, DBUS, nWR, nRD, nMREQ, nBHE, nBLE, nMWR_S_C, nMRD_S_C , data_C_S);
	save: save port map(t(3), ALUOUT_A_CS(7 downto 0), data_C_S, nMWR_S_C, irout_F_ASW, nMRD_S_C, Rtemp_S_W);
	write_back: write_back port map(PCout_F_CW, t(4), Rtemp_S_W, irout_F_ASW, z, cy_A_W, Rupdate_W_A, Rdata_W_A, PCupdate_W_F, PCnew_W_F);

end Behavioral;

