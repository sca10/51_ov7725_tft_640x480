
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name ov7725_tft -dir "D:/myapp/FPGA/pro/1_ebf_xc6slx16_pro_tutorial_code_20220302/51_ov7725_tft/51_ov7725_tft_640x480/ise_prj/planAhead_run_2" -part xc6slx16csg324-2
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "D:/myapp/FPGA/pro/1_ebf_xc6slx16_pro_tutorial_code_20220302/51_ov7725_tft/51_ov7725_tft_640x480/rtl/ov7725_tft.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/carry_latch_or.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/carry_and.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/mcb_controller/iodrp_mcb_controller.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/mcb_controller/iodrp_controller.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/comparator_sel_static.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/comparator_sel.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/comparator.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/command_fifo.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/carry_or.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/carry_latch_and.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_mcb_wrap_cmd.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_mcb_incr_cmd.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axic_register_slice.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/mcb_controller/mcb_soft_calibration.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/w_upsizer.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/r_upsizer.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/a_upsizer.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_register_slice.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_mcb_simple_fifo.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_mcb_cmd_translator.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_mcb_cmd_fsm.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/mcb_controller/mcb_soft_calibration_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_upsizer.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_mcb_w_channel.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_mcb_r_channel.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_mcb_cmd_arbiter.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_mcb_b_channel.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_mcb_aw_channel.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_mcb_ar_channel.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/mcb_controller/mcb_raw_wrapper.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/mcb_ui_top_synch.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi/axi_mcb.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/mcb_controller/mcb_ui_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr_fifo/wr_fifo.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
add_files [list {../rtl/ddr3/axi_ddr_fifo/wr_fifo.ngc}]
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr_fifo/rd_fifo.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
add_files [list {../rtl/ddr3/axi_ddr_fifo/rd_fifo.ngc}]
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/memc_wrapper.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/infrastructure.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ov7725/ov7725_data.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ov7725/ov7725_cfg.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ov7725/i2c_ctrl.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3_rw/axi_master_write.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3_rw/axi_master_read.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3_rw/axi_ctrl.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3/axi_ddr.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/tft_ctrl.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ov7725/ov7725_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ddr3/axi_ddr3_rw/axi_ddr_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../rtl/ov7725_tft_640x480.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top ov7725_tft_640x480 $srcset
add_files [list {D:/myapp/FPGA/pro/1_ebf_xc6slx16_pro_tutorial_code_20220302/51_ov7725_tft/51_ov7725_tft_640x480/rtl/ov7725_tft.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx16csg324-2
