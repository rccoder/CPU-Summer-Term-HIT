----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:48:50 07/16/2015 
-- Design Name: 
-- Module Name:    serial - Behavioral 
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

entity serial is
port(
	serialdata,clk,csn,wrn,rdn:in std_logic;
	addr:in std_logic_vector(1 downto 0);
	data:inout std_logic_vector(7 downto 0);
	intn:out std_logic
	);
end serial;

architecture Behavioral of serial is

component 	count4 is
port(
	clk : in std_logic;
	clrn : in std_logic;
	q : out std_logic_vector(3 downto 0)
	);
end component ;

component ctrl is
port(
	d9, d11 : in std_logic;
	sq7, sq6 : in std_logic;
	rq : in std_logic_vector(7 downto 0);
	clrn : inout std_logic;
	start : out std_logic;

	serial, clk : in std_logic;

	csn, wrn, rdn : in std_logic;
	addr : in std_logic_vector(1 downto 0);
	data : inout std_logic_vector(7 downto 0);
	intn : out std_logic
	);
end component;

component decode4 is
port(
	d : in std_logic_vector(3 downto 0);
	enable : in std_logic;
	q8, q9, q11 : out std_logic
	);
end component;

component reg8 is
port(
	clrn, clk : in std_logic;
	d : in std_logic_vector(7 downto 0);
	q : out std_logic_vector(7 downto 0)
	);
end component;

component sreg is
port(
	clk, clrn, serial : in std_logic;
	q : out std_logic_vector(7 downto 0)
	);
end component;

signal c:std_logic_vector(3 downto 0);
signal start,t8,t9,t11,clrn:std_logic;
signal tdata,treg:std_logic_vector(7 downto 0);


begin
unit1: count4 port map(clk => clk, clrn => start, q => c);
unit2: decode4 port map(d => c, enable => start, q8 => t8, q9 => t9, q11 => t11);
unit3: sreg port map(clk => clk, clrn => start, serial => serialdata, q => treg);
unit4: reg8 port map(clrn => clrn, clk => t8, d => treg, q => tdata);
unit5: ctrl port map(d9 => t9, d11 => t11, sq6 => treg(6), sq7 => treg(7), rq => tdata, clrn => clrn, start => start, serial => serialdata, clk => clk, csn => csn, wrn => wrn, rdn => rdn, addr => addr, data => data, intn => intn);
end Behavioral;
