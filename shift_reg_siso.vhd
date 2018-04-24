library ieee ;
use ieee.std_logic_1164.all;

use work.pgm.all;

--------Shift  register : Serial_in/Serial_out-------------------

entity shift_reg_siso  is
  generic (
    N: integer :=307
  );
  port(	
    pixin:	IN pixel;
    clk:		IN std_logic;
	  pixout:	OUT pixel
  );
end entity;

-----------------------------------------------------------------

architecture shift_reg_siso_arch of shift_reg_siso  is
  --components 
  component D_FF is port (	
    d:	IN pixel;
    clk:		IN std_logic;
	  q:	OUT pixel
    );
  end component;
  --signals
  signal temp: pixel_vector(0 to N-1);
  
begin
first: D_FF port map(clk=>clk,d=>pixin,q=>temp(0));
inside:for i in 0 to N-2 generate 
Di:D_FF port map(clk=>clk,d=>temp(i),q=>temp(i+1));
end generate;
last: D_FF port map(clk=>clk,d=>temp(N-1),q=>pixout);
end architecture shift_reg_siso_arch;

----------------------------------------------

