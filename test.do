

 
quit -sim
 
vsim -novopt work.tb_pgm
add wave -position end  sim:/tb_pgm/hist_vect
add wave -position end  sim:/tb_pgm/xin
add wave -position end  sim:/tb_pgm/yin
add wave -position end  sim:/tb_pgm/xout
add wave -position end  sim:/tb_pgm/yout
add wave -position end  sim:/tb_pgm/pixin
add wave -position end  sim:/tb_pgm/pixout
add wave -position end  sim:/tb_pgm/frminval
add wave -position end  sim:/tb_pgm/frmoutval
add wave -position end  sim:/tb_pgm/pixinclk
add wave -position end  sim:/tb_pgm/pixoutclk
add wave -position end  sim:/tb_pgm/pixinval
add wave -position end  sim:/tb_pgm/pixoutval
add wave -position end  sim:/tb_pgm/histogram
run -all