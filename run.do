vlog *v +cover
vsim -vopt work.tb_top -cover
add wave -position insertpoint sim:/tb_top/dut/*

add wave -position insertpoint  \
sim:/tb_top/my_intf/rst \
sim:/tb_top/my_intf/re \
sim:/tb_top/my_intf/en \
sim:/tb_top/my_intf/addr \
sim:/tb_top/my_intf/data_in \
sim:/tb_top/my_intf/data_out \
sim:/tb_top/my_intf/valid_out
add wave -position insertpoint  \
sim:/tb_top/clk

run -all

#coverage report -codeAll -details
#coverage report -cover -details 
#coverage report -cvg -details -output fcover_report.txt
