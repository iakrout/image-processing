library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.pgm.all;

entity threshold is
	port(
		pixin: IN pixel;
		pixinclk: IN std_logic;
		xout,yout: OUT integer range 2047 downto 0   ;
		xin,yin: IN integer range 2047 downto 0;
		pixout : OUT pixel
		
	);
end entity;

architecture threshold_arch of threshold is
--components

--signals
signal temp: pixel;
begin
         xout<=xin;
          yout<=yin;
 pixout <= 255 when (pixin > 80) else 0;
end architecture threshold_arch;
