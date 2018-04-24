-------------------------------------------------------
--! @file
--! @brief histogram process
-------------------------------------------------------
--! Use standard library 
library ieee;
--! Use logic elements
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--! Use pgm package for image 
use work.pgm.all;
--! Histogram entity description
entity hist is
	port(
	  pixinval: IN std_logic;           --! histogram : first input as integer
		pixin: IN pixel;                --! histogram : second input as pixel
		pixinclk: IN std_logic;         --! histogram : Third input 
		hist_vect : OUT int_array       --! histogram : first output as pixel an array 
	);                                  
end entity;

architecture hist_arch of hist is
------------------------------------------------
--! @brief Architecture definition of the histogram process
--! @details The histogram architecture's output is an array coposed of 2 line : one of the gray scale (0 to 255) and the second line for the occurency number.

--signals
signal temp1:int_array;
begin
hist_vect <= temp1;
  process(pixinclk)
    variable i,j: integer; 
    begin
      if(pixinclk'event and pixinclk='1')then
        if(pixinval='1')then
					 for j in 255 downto pixin loop
					   temp1(j)<= temp1(j)+1; 
		end loop;
      end if;
     end if;
  end process; 
  
end architecture hist_arch;