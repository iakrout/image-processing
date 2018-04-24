-------------------------------------------------------
--! @file
--! @brief Bluer_Filter process
-------------------------------------------------------
--! Use standard library 

library ieee;
--! Use logic elements
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--! Use pgm package for image 
use work.pgm.all;


------------------------------------------------
--! Gauss_Filter entity description
entity gauss_filter is
	port(
    pixin: IN pixel;								--! gauss_filter : first input as pixel
    xin,yin: IN integer range 2047 downto 0;        --! gauss_filter : second input as integer
    pixinclk: IN std_logic;                         --! gauss_filter : Third input 
    pixout : OUT pixel;                             --! gauss_filter : first output as pixel
    xout,yout: OUT integer range 2047 downto 0      --! gauss_filter : second output as integer
	);
end entity;
------------------------------------------------
------------------------------------------------
--! @brief Architecture definition of the gauss_filter
--! @details The gauss_filter's architecture is composed of 3 Shift Register SIPO and 3 Shift Register SISO to extract a 3*3 Matrix .
architecture gauss_filter_arch of gauss_filter is
--components
component shift_reg_sipo  is
  generic (
    N: integer :=3
  );
  port(	
    pixin:	IN pixel;
    clk:		IN std_logic;
	  pixout:	OUT pixel_vector(0 to N-1)
  );
end component;
component shift_reg_siso  is
  generic (
    N: integer :=307
  );
  port(	
    pixin:	IN pixel;
    clk:		IN std_logic;
	  pixout:	OUT pixel
  );
end component;
--signals
signal temp2,temp4: pixel;
signal temp1,temp3,temp5: pixel_vector(0 to 3-1);
begin
  G1: shift_reg_sipo port map (pixin, pixinclk, temp1);     --buffer of 3 pixels
  G2: shift_reg_siso port map (temp1(2), pixinclk, temp2);  --buffer of line-3 pixels
  G3: shift_reg_sipo port map (temp2, pixinclk, temp3);     --buffer of 3 pixels
  G4: shift_reg_siso port map (temp3(2), pixinclk, temp4);  --buffer of line-3 pixels
  G5: shift_reg_sipo port map (temp4, pixinclk, temp5);     --buffer of 3 pixels
    
  process(pixinclk)
    
    variable gauss : integer ; 
  begin
      
        if (xin=1) or (yin=1) or (xin=0) or (yin=0)then
          xout<=xin;
          yout<=yin;
          pixout<=128;
        else
          xout<=xin;
          yout<=yin;
          gauss:=(temp1(0)+2*temp1(1)+temp1(2)+2*temp3(0)+4*temp3(1)+2*temp3(2)+temp5(0)+2*temp5(1)+temp5(2))/16;
		  --! pixout is the result of the covolution of
		  --! |temp1(0) temp1(1) temp1(2)|       |1 2 1|
		  --! |temp3(0) temp3(1) temp3(2)| * 1/16|2 4 2|
		  --! |temp5(0) temp5(1) temp5(2)|       |1 2 1|
		  		  
          pixout<= gauss;
        end if;
     

  end process;
end architecture gauss_filter_arch;
------------------------------------------------

