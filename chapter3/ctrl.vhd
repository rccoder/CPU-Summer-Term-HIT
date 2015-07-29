----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:42:24 07/16/2015 
-- Design Name: 
-- Module Name:    ctrl - Behavioral 
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

entity ctrl is
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
end ctrl;


architecture main of ctrl is
	signal	clrint1, clrint2, clrint3, rbuff, rint : std_logic;
	signal	startm, odd, endd : std_logic;
	signal   perr, oerr, buff : std_logic := '0';
begin
	process(csn, wrn, addr)
	begin
		clrn <= '1';
		clrint1 <= '1';
		clrint2 <= '1';
		clrint3 <= '1';
		if csn = '0' and wrn = '0' then
			case addr is
				when "00" => clrn <= '0';clrint1 <= '0'; clrint2 <= '0'; clrint3 <= '0';
				when "01" => clrint1 <= '0';
				when "10" => clrint2 <= '0';
				when "11" => clrint3 <= '0';
				when others => null;
			end case;
		end if;
	end process;
	
	process(csn, rdn,addr)
	begin
		rbuff <= '1';
		rint <= '1';
		if csn = '0' and rdn = '0' then
			case addr is
				when "00" => rbuff <= '0';
				when "01" => rint <= '0';
				when others => null;
			end case;
		else
		end if;
	end process;

	process(sq7, rq)
	begin
		odd <= sq7 xor rq(0) xor rq(1) xor rq(2) xor rq(3) xor rq(4) xor rq(5) xor rq(6) xor rq(7);
	end process;

	process(sq7, sq6)
	begin
		endd <= sq7 and sq6;
	end process;

	process(clrn, clk)
	begin
		if clrn = '0' then
			startm <= '0';
		elsif clk = '1' and clk'event then
			startm <= not serial;
		end if;
	end process;

	process(clrn, startm)
	begin
		if clrn = '0' then
			start <= '0';
		elsif startm = '1' and startm'event then
			start <= '1';
		end if;
	end process;

	process(clrint2, d9)
	begin
		if clrint2 = '0' then
			perr <= '0';
		elsif d9 = '1' and d9'event then
			perr <= odd;
		end if;
	end process;

	process(clrint1, d11)
	begin
		if clrint1 = '0' then
			buff <= '0';
		elsif d11 = '1' and d11'event then
			buff <= endd;
		end if;
	end process;

	process(clrint3, startm)
	begin
		if clrint3 = '0' then
			oerr <= '0';
		elsif startm = '1' and startm'event then
			oerr <= buff;
		end if;
	end process;

	process(perr, oerr, buff)
	begin
		intn <= not (perr or oerr or buff);
	end process;

	process(rbuff, rint, perr, oerr, buff, rq)
	begin
		if rbuff = '0' then
			data <= rq;
		elsif rint = '0' then
			data(0) <= buff;
			data(1) <= perr;
			data(2) <= oerr;
			data(7 downto 3) <= "00000";
		else
			data <= "ZZZZZZZZ";			
		end if;
	end process;

end main;
