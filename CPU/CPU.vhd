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
           ABUS : out  STD_LOGIC_VECTOR (15 downto 0);
           DBUS : inout  STD_LOGIC_VECTOR (15 downto 0);
           nMREQ : out  STD_LOGIC;
           nRD : out  STD_LOGIC;
           nWR : out  STD_LOGIC;
           nBHE : out  STD_LOGIC;
           nBLE : out  STD_LOGIC);
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
			irnew : in  STD_LOGIC_VECTOR (15 downto 0);        --访存模块输入的IR
         pcnew : in  STD_LOGIC_VECTOR (15 downto 0);        --回写模块，更新PC
         clk : in  STD_LOGIC;                               --节拍
         pcupdate : in  STD_LOGIC;                          --告诉要更新PC了
         reset : in  STD_LOGIC;                             --复位
         t0 : in  STD_LOGIC;
         t1 : in  STD_LOGIC;
         irout : out  STD_LOGIC_VECTOR (15 downto 0);        --输出的IR
         pcout : out  STD_LOGIC_VECTOR (15 downto 0);
         irrep : out  STD_LOGIC
		);
	end component;
	
	component ALU is
		port (
		   -- 实现准备和运算功能
		   enable_t : in std_logic; -- 准备和运算功能使能信号
			ir : in std_logic_vector(15 downto 0);   --16位的IR信号
	  
			-- 向访存控制模块输出
			sig_reg7aluout : out std_logic_vector ( 15 downto 0 ); -- 暂存器输出端口
			sig_reg7addrout : out std_logic_vector ( 15 downto 0 ); -- 8位地址输出端口
			--reg7_out : out std_logic_vector ( 7 downto 0 );
	  
			-- 实现回写功能
			enable_wb : in std_logic ; -- 回写功能使能
			reg_wb : in std_logic_vector (7 downto 0 );  -- 回写接收端口
	  
			-- 进位标志
			cy : out std_logic 
		);
	end component;
	
	component control is
		port (
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
	end component;
	
	component save is
		port (
			t : in  STD_LOGIC;
			ALUOUT : in std_logic_vector(7 downto 0);     --- ALU输出的值
			data : in std_logic_vector(7 downto 0);       --- 接收区属的时候访存控制的数据
			nMWR : out std_logic;                         
			IR : in  STD_LOGIC_VECTOR (15 downto 0);
			nMRD : out  STD_LOGIC;
			Rtemp : out std_logic_vector(7 downto 0)
		);                                  
	end component;
	
	component write_back is
		port (
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
	end component;
	
signal t : STD_LOGIC_VECTOR(4 downto 0);      --正常节拍   
signal IR_C_F : STD_LOGIC_VECTOR(15 downto 0);  --  取指模块取出的ir
signal PCout_F_CW : STD_LOGIC_VECTOR(15 downto 0);  -- PC 送往访存控制取指，送回写模块
signal PCnew_W_F : STD_LOGIC_VECTOR(15 downto 0);    -- 跳转的时候要更新的PC
signal PCupdate_W_F : STD_LOGIC;                    -- 跳转更新PC使能信号
signal irout_F_ASW : STD_LOGIC_VECTOR(15 downto 0);  --取指模块取到的Ir,会送往ALU 存储 和回写
signal irreq_F_C : STD_LOGIC;                 -- 取指送往访存控制，告诉要取指令了
signal ALUOUT_A_CS : STD_LOGIC_VECTOR(15 downto 0);    ---ALU 送往其他模块的aluout
signal Addr_A_C : STD_LOGIC_VECTOR(15 downto 0);      --- ALU 送往访存的addr
signal Rupdate_W_A : STD_LOGIC;                         ---回写模块送往ALU的更改寄存器使能信号
signal Rdata_W_A : STD_LOGIC_VECTOR(7 downto 0);         ----回写模块输出的要更新的寄存器的值
signal data_C_S : STD_LOGIC_VECTOR(7 downto 0);           -- 取数的时候使用
signal nMWR_S_C : STD_LOGIC;                              --写数使能
signal nMRD_S_C : STD_LOGIC;                              --读数使能
signal Rtemp_S_W : STD_LOGIC_VECTOR(7 downto 0);          -- 存储模块向回写模块
signal cy_A_W : STD_LOGIC;                                --进位
begin
	
	u1: clock port map(CLK, RST, t);
	u2: fetch port map(IR_C_F, PCnew_W_F, CLK , PCupdate_W_F, RST, t(0), t(1), irout_F_ASW, PCout_F_CW, irreq_F_C);
	u3: ALU port map(t(2), irout_F_ASW, ALUOUT_A_CS, Addr_A_C, Rupdate_W_A, Rdata_W_A, cy_A_W);
	u4: control port map(irreq_F_C, IR_C_F, PCout_F_CW, ALUOUT_A_CS(7 downto 0), Addr_A_C, ABUS, DBUS, nWR, nRD, nMREQ, nBHE, nBLE, nMWR_S_C, nMRD_S_C , data_C_S);
	u5: save port map(t(3), ALUOUT_A_CS(7 downto 0), data_C_S, nMWR_S_C, irout_F_ASW, nMRD_S_C, Rtemp_S_W);
	u6: write_back port map(PCout_F_CW, t(4), Rtemp_S_W, irout_F_ASW, cy_A_W, Rupdate_W_A, Rdata_W_A, PCupdate_W_F, PCnew_W_F);

end Behavioral;

