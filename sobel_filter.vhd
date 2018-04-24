library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.math_real.all;
use IEEE.math_real.sqrt;
USE ieee.numeric_std.ALL;
use work.pgm.all;

------------------------------------------------
entity sobel_filter is
	port(
    pixin: IN pixel;
    xin,yin: IN integer range 2047 downto 0;
    pixinclk: IN std_logic;
    pixout : OUT pixel;
    xout,yout: OUT integer range 2047 downto 0
	);
end entity;
------------------------------------------------
architecture sobel_filter_arch of sobel_filter is
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
    variable sobl1,sobl2,sobl,sobl4 : integer;
    variable sobel3 : integer ; 
  begin
      -- clock rising edge
      --if (pixinclk='1' and pixinclk'event) then
        if (xin=1) or (yin=1) or (xin=0) or (yin=0)then
          xout<=xin;
          yout<=yin;
          pixout<=128;
        else
          xout<=xin;
          yout<=yin;
          sobl1:=-temp1(0)-2*temp1(1)-temp1(2)+0*temp3(0)+0*temp3(1)+0*temp3(2)+temp5(0)+2*temp5(1)+temp5(2);
          if sobl1<0 then
            sobl1:=0;
          elsif sobl1>255 then
            sobl1:=255;
          end if;
          sobl2:=-temp1(0)+0*temp1(1)+temp1(2)-2*temp3(0)+0*temp3(1)+2*temp3(2)-temp5(0)+0*temp5(1)+temp5(2);
          if sobl2<0 then
            sobl2:=0;
          elsif sobl2>255 then
            sobl2:=255;
          end if;
          
   sobl:=conv_integer((abs(sobl1)+abs(sobl2))/2);
          
          pixout<= sobl;
        end if;
     

  end process;
end architecture sobel_filter_arch;
------------------------------------------------
