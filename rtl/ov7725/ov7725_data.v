`timescale  1ns/1ns
////////////////////////////////////////////////////////////////////////
// Author        : EmbedFire
// Create Date   : 2019/11/01
// Module Name   : ov7725_data
// Project Name  : ov7725
// Target Devices: Xilinx XC6SLX16
// Tool Versions : ISE 14.7
// Description   : ov7725摄像头图像数据采集模块
// 
// Revision      : V1.0
// Additional Comments:
// 
// 实验平台: 野火_踏浪Pro_FPGA开发板
// 公司    : http://www.embedfire.com
// 论坛    : http://www.firebbs.cn
// 淘宝    : https://fire-stm32.taobao.com
////////////////////////////////////////////////////////////////////////

module  ov7725_data
(
    input   wire            sys_rst_n       ,   //复位信号
// ov7725
    input   wire            ov7725_pclk     ,   //摄像头像素时钟
    input   wire            ov7725_href     ,   //摄像头行同步信号
    input   wire            ov7725_vsync    ,   //摄像头场同步信号
    input   wire    [ 7:0]  ov7725_data     ,   //摄像头图像数据
// 写FIFO
    output  wire            ov7725_wr_en    ,   //图像数据有效使能信号
    output  wire    [15:0]  ov7725_data_out     //图像数据
);

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//

//parameter define
parameter   PIC_WAIT    =   4'd10;  //图像稳定前等待帧图像个数

//wire  define
wire            pic_flag    ;   //帧图像标志信号,每拉高一次,代表一帧完整图像

//reg   define
reg             ov7725_vsync_dly1    ;   //摄像头输入场同步信号打拍
reg             ov7725_vsync_dly2;
reg     [3:0]   cnt_pic             ;   //图像帧计数器
reg             pic_valid           ;   //帧有效标志信号
reg     [7:0]   pic_data_reg        ;   //输入8位图像数据缓存
reg     [15:0]  data_out_reg        ;   //输出16位图像数据缓存
reg             data_flag           ;   //输入8位图像数据缓存
reg             data_flag_dly1      ;   //图像数据拼接标志信号打拍

//********************************************************************//
//***************************** Main Code ****************************//
//********************************************************************//

//ov7725_vsync_dly:摄像头输入场同步信号打拍
always@(posedge ov7725_pclk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0) begin
        ov7725_vsync_dly1    <=  1'b0;
        ov7725_vsync_dly2    <=  1'b0;
        end
    else
        begin
        ov7725_vsync_dly1    <=  ov7725_vsync;
        ov7725_vsync_dly2    <=  ov7725_vsync_dly1;
        end

//pic_flag:帧图像标志信号,每拉高一次,代表一帧完整图像
assign  pic_flag = ((ov7725_vsync_dly1 == 1'b0)
                    && (ov7725_vsync == 1'b1)) ? 1'b1 : 1'b0;

//cnt_pic:图像帧计数器
always@(posedge ov7725_pclk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt_pic <=  4'd0;
    else    if(cnt_pic < PIC_WAIT)
        cnt_pic <=  cnt_pic + 1'b1;
    else
        cnt_pic <=  cnt_pic;

//pic_valid:真有效标志
always@(posedge ov7725_pclk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pic_valid   <=  1'b0;
    else    if((cnt_pic == PIC_WAIT) && (pic_flag == 1'b1))
        pic_valid   <=  1'b1;
    else
        pic_valid   <=  pic_valid;

//data_out_reg,pic_data_reg,data_flag:输出16位图像数据缓冲
//输入8位图像数据缓存输入8位,图像数据缓存
always@(posedge ov7725_pclk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        begin
            data_out_reg    <=  16'd0;
            pic_data_reg    <=  8'd0;
            data_flag       <=  1'b0;
        end
    else    if(ov7725_href == 1'b1)
        begin
            data_flag       <=  ~data_flag;
            pic_data_reg    <=  ov7725_data;
            data_out_reg    <=  data_out_reg;
        if(data_flag == 1'b1)
            data_out_reg    <=  {pic_data_reg,ov7725_data};  //两个字节一个像素
        else
            data_out_reg    <=  data_out_reg;
        end
    else
        begin
            data_flag       <=  1'b0;
            pic_data_reg    <=  8'd0;
            data_out_reg    <=  data_out_reg;
        end

//data_flag_dly1:图像数据缓存打拍
always@(posedge ov7725_pclk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        data_flag_dly1  <=  1'b0;
    else
        data_flag_dly1  <=  data_flag;

//ov7725_data_out:输出16位图像数据
assign  ov7725_data_out = (pic_valid == 1'b1) ? data_out_reg : 16'b0;

//ov7725_wr_en:输出16位图像数据使能
assign  ov7725_wr_en = (pic_valid == 1'b1) ? data_flag_dly1 : 1'b0;

endmodule
