library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


use work.pgm.all;

entity pgm_trt is
	port(
		pixin: IN pixel;
		xin,yin: IN integer range 2047 downto 0;
		pixinclk, frminval,pixinval : IN std_logic;
		pixout : OUT pixel;
		xout,yout: OUT integer range 2047 downto 0;
		pixoutclk, frmoutval,pixoutval: OUT std_logic;
		hist_vect : OUT int_array
	);
end entity;

architecture trt_arch of pgm_trt is
--components
----------------------------blur_filter----------
component blur_filter
  port (
    pixin: IN pixel;
    xin,yin: IN integer range 2047 downto 0;
    pixinclk: IN std_logic;
    pixout : OUT pixel;
    xout,yout: OUT integer range 2047 downto 0
    );
end component;
------------------------------gauss_filter-------
component gauss_filter is
port(
    pixin: IN pixel;
    xin,yin: IN integer range 2047 downto 0;
    pixinclk: IN std_logic;
    pixout : OUT pixel;
    xout,yout: OUT integer range 2047 downto 0
	);
end component;

----------------------------Sobel_filter----------
component sobel_filter
  port (
    pixin: IN pixel;
    xin,yin: IN integer range 2047 downto 0;
    pixinclk: IN std_logic;
    pixout : OUT pixel;
    xout,yout: OUT integer range 2047 downto 0
    );
end component;

----------------------------threshold----------
component threshold 
  port(
    
    pixin: IN pixel;
		pixinclk: IN std_logic;
		 xout,yout: OUT integer range 2047 downto 0;
		 xin,yin: IN integer range 2047 downto 0;
		pixout : OUT pixel
  );
end component;
----------------------------histogram----------
component hist is
	port(
	  pixinval: IN std_logic;
		pixin: IN pixel;
		pixinclk: IN std_logic;
		hist_vect : OUT int_array
	);
end component;

--signals

begin
G1: blur_filter port map (pixin, xin, yin, pixinclk, pixout, xout, yout);
-- G2: gauss_filter port map (pixin, xin, yin, pixinclk, pixout, xout, yout);
--G3: sobel_filter port map (pixin, xin, yin, pixinclk, pixout, xout, yout);
--G4: threshold port map  ( pixin,pixinclk, xout, yout,xin, yin, pixout);
--G5: hist port map (pixinval,pixin,pixinclk,hist_vect);
 
     
  pixoutclk<=pixinclk;
  pixoutval<=pixinval;
  frmoutval<=frminval;
end architecture trt_arch;
