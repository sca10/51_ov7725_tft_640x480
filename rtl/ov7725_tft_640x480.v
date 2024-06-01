`timescale  1ns/1ns
////////////////////////////////////////////////////////////////////////
// Author        : EmbedFire
// Create Date   : 2019/11/01
// Module Name   : ov7725_tft_640x480
// Project Name  : ov7725_tft_640x480
// Target Devices: Xilinx XC6SLX16
// Tool Versions : ISE 14.7
// Description   : 顶层模块
// 
// Revision      : V1.0
// Additional Comments:
// 
// 实验平台: 野火_踏浪Pro_FPGA开发板
// 公司    : http://www.embedfire.com
// 论坛    : http://www.firebbs.cn
// 淘宝    : https://fire-stm32.taobao.com
////////////////////////////////////////////////////////////////////////

module  ov7725_tft_640x480
(
    input   wire            sys_clk     ,  //系统时钟
    input   wire            sys_rst_n   ,  //系统复位，低电平有效
//摄像头接口
    input   wire            ov7725_pclk ,  //摄像头数据像素时钟
    input   wire            ov7725_vsync,  //摄像头场同步信号
    input   wire            ov7725_href ,  //摄像头行同步信号
    input   wire    [7:0]   ov7725_data ,  //摄像头数据
    output  wire            ov7725_rst_n,  //摄像头复位信号，低电平有效
    output  wire            ov7725_pwdn ,  //摄像头时钟选择信号
    output  wire            sccb_scl    ,  //摄像头SCCB_SCL线
    inout   wire            sccb_sda    ,  //摄像头SCCB_SDA线
//DDR3接口
    inout  [15:0]   mcb3_dram_dq,     //数据线    
    output [12:0]   mcb3_dram_a,      //地址线
    output [2:0]    mcb3_dram_ba,     //bank线
    output          mcb3_dram_ras_n,  //行使能信号，低电平有效
    output          mcb3_dram_cas_n,  //列使能信号，低电平有效
    output          mcb3_dram_we_n,   //写使能信号，低电平有效
    output          mcb3_dram_odt,    
    output          mcb3_dram_reset_n,//ddr3复位
    output          mcb3_dram_cke,    //ddr3时钟使能信号
    output          mcb3_dram_dm,     //ddr3低8位掩码
    inout           mcb3_dram_udqs,   //高字节数据选取脉冲差分信号
    inout           mcb3_dram_udqs_n, //高字节数据选取脉冲差分信号
    inout           mcb3_rzq,         
    inout           mcb3_zio,         
    output          mcb3_dram_udm,    //ddr3高8位掩码
    inout           mcb3_dram_dqs,    //低字节数据选取脉冲差分信号
    inout           mcb3_dram_dqs_n,  //低字节数据选取脉冲差分信号
    output          mcb3_dram_ck,     //ddr3差分时钟
    output          mcb3_dram_ck_n,   //ddr3差分时钟
//TFT接口
    output  wire            tft_clk     ,   //TFT时钟
    output  wire            tft_de      ,   //TFT使能
    output  wire            tft_bl      ,   //背光
    output  wire            tft_hs      ,   //行同步信号
    output  wire            tft_vs      ,   //场同步信号
    output  wire    [23:0]  tft_rgb         //红绿蓝三原色输出 
);

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//

//parameter define

            
parameter   H_PIXEL     =   24'd640 ,   //水平方向像素个数
            V_PIXEL     =   24'd480 ;   //垂直方向像素个数

//wire  define

wire            clk_24m         ;   //25mhz时钟,提供给tft驱动时钟
wire            clk_33m         ;
wire            rst_n           ;   //总复位信号
wire            cfg_done        ;   //摄像头初始化完成
wire            wr_en           ;   //DDR写使能
wire   [15:0]   wr_data         ;   //DDR写数据
wire            rd_en           ;   //DDR读使能
wire   [15:0]   rd_data         ;   //DDR读数据
wire            sys_init_done   ;   //系统初始化完成
wire            ddr3_init_done  ;   //ddr3初始化完成

wire            c3_clk0;
wire            c3_rst0;
wire            clk_50m;
wire    [15:0]  tft_rgb_16;
wire    [7:0]   rgb_r;
wire    [7:0]   rgb_g;
wire    [7:0]   rgb_b;
//********************************************************************//
//***************************** Main Code ****************************//
//********************************************************************//

//rst_n:复位信号
assign  rst_n = sys_rst_n & ddr3_init_done ;
assign  sys_init_done = ddr3_init_done & cfg_done;
//ov7725_rst_n:摄像头复位,固定高电平
assign  ov7725_rst_n = 1'b1;

//ov7725_pwdn
assign  ov7725_pwdn = 1'b0;

 
//------------- ov7725_top_inst -------------
wire came_start;
ov7725_top  ov7725_top_inst(

    .sys_clk         (clk_24m       ),   //系统时钟
    .sys_rst_n       (rst_n         ),   //复位信号
    .sys_init_done   (sys_init_done ),   //系统初始化完成

    .ov7725_pclk     (ov7725_pclk   ),   //摄像头像素时钟
    .ov7725_href     (ov7725_href   ),   //摄像头行同步信号
    .ov7725_vsync    (ov7725_vsync  ),   //摄像头场同步信号
    .ov7725_data     (ov7725_data   ),   //摄像头图像数据

    .cfg_done        (cfg_done      ),   //寄存器配置完成
    .sccb_scl        (sccb_scl      ),   //SCL
    .sccb_sda        (sccb_sda      ),   //SDA
    .ov7725_wr_en    (wr_en         ),   //图像数据有效使能信号
    .ov7725_data_out (wr_data       )    //图像数据
);



//DDR读写控制部分
axi_ddr_top ddr_rw_inst(
    //是否开启pingpang操作
    .pingpang          (1'b1            ),//开启乒乓操作
    //写用户接口
    .user_wr_clk       (ov7725_pclk     ),//写时钟
    .data_wren         (wr_en           ),//写使能，高电平有效
    .data_wr           (wr_data         ),//写数据16位
    .wr_b_addr         (30'd0           ),//写起始地址
    .wr_e_addr         (H_PIXEL*V_PIXEL*2),//写结束地址
    .wr_rst            (1'b0            ),//写地址复位 wr_rst
    //读用户接口
    .user_rd_clk       (clk_33m          ),//读时钟
    .data_rden         (rd_en           ),//读使能，高电平有效
    .data_rd           (rd_data         ),//读数据16位
    .rd_b_addr         (30'd0           ),//读起始地址
    .rd_e_addr         (H_PIXEL*V_PIXEL*2),//写结束地址
    .rd_rst            (1'b0            ),//读地址复位 rd_rst
    .read_enable       (1'b1            ),//读使能
    //时钟和复位
    .ui_clk            (c3_clk0         ),//ddr操作时钟125m
    .ui_rst            (c3_rst0         ),//ddr产生的复位信号
    .use_clk1          (clk_24m         ),//从ddr3配置的pll产生的clk1时钟
    .use_clk2          (clk_33m         ),//从ddr3配置的pll产生的clk2时钟
    .c3_calib_done     (ddr3_init_done  ),//代表ddr初始化完成
    //物理接口
    .mcb3_dram_dq      (mcb3_dram_dq    ),//数据线    
    .mcb3_dram_a       (mcb3_dram_a     ),//地址线
    .mcb3_dram_ba      (mcb3_dram_ba    ),//bank线
    .mcb3_dram_ras_n   (mcb3_dram_ras_n ),//行使能信号，低电平有效
    .mcb3_dram_cas_n   (mcb3_dram_cas_n ),//列使能信号，低电平有效
    .mcb3_dram_we_n    (mcb3_dram_we_n  ),//写使能信号，低电平有效
    .mcb3_dram_odt     (mcb3_dram_odt   ),//阻抗配置引脚odt
    .mcb3_dram_cke     (mcb3_dram_cke   ),//ddr3时钟使能信号
    .mcb3_dram_dm      (mcb3_dram_dm    ),//ddr3低8位掩码
    .mcb3_dram_udqs    (mcb3_dram_udqs  ),//高字节数据选取脉冲差分信号
    .mcb3_dram_udqs_n  (mcb3_dram_udqs_n),//高字节数据选取脉冲差分信号
    .mcb3_rzq          (mcb3_rzq        ),//阻抗配置引脚rzq
    .mcb3_zio          (mcb3_zio        ),//阻抗配置引脚zio
    .sys_clk           (sys_clk         ),//ddr输入时钟
    .sys_rst_n         (sys_rst_n       ),//ddr复位信号
    .mcb3_dram_udm     (mcb3_dram_udm   ),//ddr3高8位掩码
    .mcb3_dram_reset_n (mcb3_dram_reset_n),//ddr3复位
    .mcb3_dram_dqs     (mcb3_dram_dqs   ),//低字节数据选取脉冲差分信号
    .mcb3_dram_dqs_n   (mcb3_dram_dqs_n ),//低字节数据选取脉冲差分信号
    .mcb3_dram_ck      (mcb3_dram_ck    ),//ddr3差分时钟
    .mcb3_dram_ck_n    (mcb3_dram_ck_n  ) //ddr3差分时钟
);
 

tft_ctrl tft_ctrl_inst
(
    .clk_33m    (clk_33m    ) ,   //输入时钟,频率33MHz
    .sys_rst_n  (rst_n      ) ,   //系统复位,低电平有效
    .data_in    (rd_data    ) ,   //待显示数据
    .data_req   (rd_en      ) ,   //数据请求信号
    .rgb_tft    (tft_rgb_16 ) ,   //TFT显示数据
    .hsync      (tft_hs     ) ,   //TFT行同步信号
    .vsync      (tft_vs     ) ,   //TFT场同步信号
    .tft_clk    (tft_clk    ) ,   //TFT像素时钟
    .tft_de     (tft_de     ) ,   //TFT数据使能
    .tft_bl     (tft_bl     )     //TFT背光信号
);

//rgb16 565转rgb24 888
assign rgb_r={tft_rgb_16[15:11],3'd0};
assign rgb_g={tft_rgb_16[10:5],2'd0};
assign rgb_b={tft_rgb_16[4:0],3'd0};
assign tft_rgb={rgb_r,rgb_g,rgb_b};
endmodule



