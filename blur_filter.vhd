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

--! Use pgm package for image reading
use work.pgm.all;

------------------------------------------------
--! Bluer_Filter entity description

entity blur_filter is
	port(
    pixin: IN pixel; 							--! blur_filter : first input as pixel
    xin,yin: IN integer range 2047 downto 0;	--! blur_filter : second input as integer
    pixinclk: IN std_logic;						--! blur_filter : Third input 
    pixout : OUT pixel;							--! blur_filter : first output as pixel
    xout,yout: OUT integer range 2047 downto 0	--! blur_filter : second output as integer
	);
end entity;
------------------------------------------------
--! @brief Architecture definition of the Bluer_Filter
--! @details The Bluer_Filter's architecture is composed of 3 Shift Register SIPO and 3 Shift Register SISO to extract a 3*3 Matrix .
architecture blur_filter_arch of blur_filter is
--! Use of shift_reg_sipo component
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

--! Use of shift_reg_siso component
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
	  G1: shift_reg_sipo port map (pixin, pixinclk, temp1);     --! buffer of 3 pixels
	  G2: shift_reg_siso port map (temp1(2), pixinclk, temp2);  --! buffer of line-3 pixels
	  G3: shift_reg_sipo port map (temp2, pixinclk, temp3);     --! buffer of 3 pixels
	  G4: shift_reg_siso port map (temp3(2), pixinclk, temp4);  --! buffer of line-3 pixels
	  G5: shift_reg_sipo port map (temp4, pixinclk, temp5);     --! buffer of 3 pixels
		
  process(pixinclk)
      begin
      
        if (xin=1) or (yin=1) or (xin=0) or (yin=0)then
          xout<=xin;
          yout<=yin;
          pixout<=128;
        else
          xout<=xin;
          yout<=yin;
          pixout<=conv_integer((temp1(0)+temp1(1)+temp1(2)+temp3(0)+temp3(1)+temp3(2)+temp5(0)+temp5(1)+temp5(2))/9);
		  --! pixout is the result of the covolution of  
		  --! |temp1(0) temp1(1) temp1(2)|      |1 1 1|
		  --! |temp3(0) temp3(1) temp3(2)| * 1/9|1 1 1|
		  --! |temp5(0) temp5(1) temp5(2)|      |1 1 1|
        end if;
     

  end process;
end architecture blur_filter_arch;
------------------------------------------------