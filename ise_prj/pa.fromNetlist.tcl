
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name ov7725_tft -dir "D:/myapp/FPGA/pro/1_ebf_xc6slx16_pro_tutorial_code_20220302/51_ov7725_tft/51_ov7725_tft_640x480/ise_prj/planAhead_run_2" -part xc6slx16csg324-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/myapp/FPGA/pro/1_ebf_xc6slx16_pro_tutorial_code_20220302/51_ov7725_tft/51_ov7725_tft_640x480/ise_prj/ov7725_tft_640x480.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/myapp/FPGA/pro/1_ebf_xc6slx16_pro_tutorial_code_20220302/51_ov7725_tft/51_ov7725_tft_640x480/ise_prj} {../rtl/ddr3/axi_ddr_fifo} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "D:/myapp/FPGA/pro/1_ebf_xc6slx16_pro_tutorial_code_20220302/51_ov7725_tft/51_ov7725_tft_640x480/rtl/ov7725_tft.ucf" [current_fileset -constrset]
add_files [list {D:/myapp/FPGA/pro/1_ebf_xc6slx16_pro_tutorial_code_20220302/51_ov7725_tft/51_ov7725_tft_640x480/rtl/ov7725_tft.ucf}] -fileset [get_property constrset [current_run]]
link_design
