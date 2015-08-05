----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:53:37 07/10/2015 
-- Design Name: 
-- Module Name:    dff4 - Behavioral 
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

entity dff4 is
    Port ( A : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           B : out  STD_LOGIC);
end dff4;

architecture Behavioral of dff4 is

component dff
	Port ( d : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           q : out  STD_LOGIC);
end component;

signal temp:std_logic_vector(0 to 4):="00000";


begin

temp(0)<=A;
l1:for i in 0 to 3 generate
	--l2:dff port map(temp(i),clk,'0',temp(i+1));
	temp(i+1)<=temp(i) when (clk'event and clk='1') else temp(i+1);
	end generate;
B<=temp(4);

end Behavioral;

