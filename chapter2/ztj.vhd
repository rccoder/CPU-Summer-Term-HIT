----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:56:13 07/09/2015 
-- Design Name: 
-- Module Name:    zhuang - Behavioral 
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

entity zhuang is
    Port ( read_wright : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           oe : out  STD_LOGIC;
           we : out  STD_LOGIC);
end zhuang;

architecture Behavioral of zhuang is
type state is (R,W,N);
signal pr_state,nx_state:state;
signal temp:std_logic;
begin
process(clk,reset)
begin
	if(reset='1')then
		pr_state<=N;
		if(clk'event and clk='1')then
			oe<='X';we<='X';
		end if;
	elsif(clk'event and clk='1')then
		if temp ='1' then
			oe<='1';
			we<='0';
		else
			oe<='0';
			we<='1';
		end if;
		pr_state<=nx_state;
	end if;
end process;

process(read_wright)
begin
	case pr_state is
		when N=>
		if(read_wright='1')then nx_state<=R;temp<='1';
		else nx_state<=W;temp<='0';
		end if;
		when W=>
		if(read_wright='1')then nx_state<=R;temp<='1';
		end if;
		when R=>
		if(read_wright='0')then nx_state<=W;temp<='0';
		end if;
	end case;
end process;
end Behavioral;

