-------------------------------------------------------
--! @file
--! @brief   D_flip_flop 
-------------------------------------------------------
--! Use standard library 
library ieee ;
--! Use logic elements
use ieee.std_logic_1164.all;
--! Use pgm package for image 
use work.pgm.all;

---------------------------------------------
--! D_flip_flop entity description
entity D_FF is
  port(
    d:	IN pixel;				--! D_flip_flop : first input as pixel
 	  clk:		IN std_logic;	--! D_flip_flop : second input 
	  q:	OUT pixel           --! D_flip_flop : output as pixel
	  );                           
end entity;                     

----------------------------------------------
--! @brief Architecture definition of the D_flip_flop
--! @details The D_flip_flop is the basic element of the shift register
architecture D_FF_arch of D_FF is
begin

    process(clk)
    begin

        -- clock rising edge

	if (clk='1' and clk'event) then
	    q <= d;
	end if;

    end process;	

end architecture D_FF_arch;

----------------------------------------------
