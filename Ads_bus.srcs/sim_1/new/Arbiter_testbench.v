`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2023 07:22:05 PM
// Design Name: 
// Module Name: Arbiter_testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Arbiter_testbench();
    `include "aribiter_params.vh"
    reg clk;
    initial begin
        clk=0;
        forever #(40/2) clk<=~clk;
    end
    //io
    reg reset=1;
    reg split=0;
    
    //master1
    reg mast1_valid,mast1_type=0;
    reg[1:0] mast1_id=master1;
    reg[14:0] mast1_addr=0;
    reg[31:0] mast1_wdata=0;
    wire[31:0] mast1_rdata;
    wire mast1_ready;
    
    //master2
    reg mast2_valid,mast2_type=0;
    reg[1:0] mast2_id=master2;
    reg[14:0] mast2_addr=0;
    reg[31:0] mast2_wdata=0;
    wire[31:0] mast2_rdata;
    wire mast2_ready;
    
    //master3
    reg mast3_valid,mast3_type=0;
    reg[1:0] mast3_id=master3;
    reg[14:0] mast3_addr=0;
    reg[31:0] mast3_wdata=0;
    wire[31:0] mast3_rdata;
    wire mast3_ready;
    
    //slave ready signals
    reg slav1_ready,slav2_ready,slav3_ready=0;
    
    //connect arbiter and slaves
    
    //connect slaves
    //slav1
    wire slav1_valid, slav1_type;
    wire[1:0] slav1_master_id;
    wire[31:0] slav1_wdata;
    wire[31:0] slav1_rdata;
    wire[11:0] slav1_addr;
    slave_for_testbench s1(.clk(clk),.slav_valid(slav1_valid),.slav_type(slav1_type),.slav_master_id(slav1_master_id),.slav_wdata(slav1_wdata),.slav_addr(slav1_addr),.slav_ready(slav1_ready),.slav_rdata(slav1_rdata));
    
    //slav2
    wire slav2_valid, slav2_type;
    wire[1:0] slav2_master_id;
    wire[31:0] slav2_wdata;
    wire[31:0] slav2_rdata;
    wire[11:0] slav2_addr;
    slave_for_testbench s2(.clk(clk),.slav_valid(slav2_valid),.slav_type(slav2_type),.slav_master_id(slav2_master_id),.slav_wdata(slav2_wdata),.slav_addr(slav2_addr),.slav_ready(slav2_ready),.slav_rdata(slav2_rdata));
    
    //slav3
    wire slav3_valid, slav3_type;
    wire[1:0] slav3_master_id;
    wire[31:0] slav3_wdata;
    wire[31:0] slav3_rdata;
    wire[11:0] slav3_addr;
    slave_for_testbench s3(.clk(clk),.slav_valid(slav3_valid),.slav_type(slav3_type),.slav_master_id(slav3_master_id),.slav_wdata(slav3_wdata),.slav_addr(slav3_addr),.slav_ready(slav3_ready),.slav_rdata(slav3_rdata));
    
    //connect arbiter
    Arbiter a(.clk(clk),.mast1_valid(mast1_valid),.mast1_type(mast1_type),.mast1_id(mast1_id),.mast1_addr(mast1_addr),.mast1_wdata(mast1_wdata),.mast1_rdata(mast1_rdata),.mast1_ready(mast1_ready),
                        .mast2_valid(mast2_valid),.mast2_type(mast2_type),.mast2_id(mast2_id),.mast2_addr(mast2_addr),.mast2_wdata(mast2_wdata),.mast2_rdata(mast2_rdata),.mast2_ready(mast2_ready),
                        .mast3_valid(mast3_valid),.mast3_type(mast3_type),.mast3_id(mast3_id),.mast3_addr(mast3_addr),.mast3_wdata(mast3_wdata),.mast3_rdata(mast3_rdata),.mast3_ready(mast3_ready),
                        .slav1_valid(slav1_valid),.slav1_type(slav1_type),.slav1_master_id(slav1_master_id),.slav1_wdata(slav1_wdata),.slav1_rdata(slav1_rdata),.slav1_addr(slav1_addr),.slav1_ready(slav1_ready),
                        .slav2_valid(slav2_valid),.slav2_type(slav2_type),.slav2_master_id(slav2_master_id),.slav2_wdata(slav2_wdata),.slav2_rdata(slav2_rdata),.slav2_addr(slav2_addr),.slav2_ready(slav2_ready),
                        .slav3_valid(slav3_valid),.slav3_type(slav3_type),.slav3_master_id(slav3_master_id),.slav3_wdata(slav3_wdata),.slav3_rdata(slav3_rdata),.slav3_addr(slav3_addr),.slav3_ready(slav3_ready),.slav3_split(split),
                        .reset(reset)            
    );
    
    initial
    begin
       @(posedge clk);
       reset=1;
       @(posedge clk);
       reset=0;
       @(posedge clk);
       mast1_valid=1;
       mast1_type=write;
       mast1_addr={slave1,12'd5};
       mast1_wdata=32'd568;
       slav1_ready=0;
       split=1;
       
       mast2_valid=1;
       mast2_type=write;
       mast2_addr={slave1,12'd6};
       mast2_wdata=32'd700;
       slav1_ready=1;
       
       @(posedge clk);
       @(posedge clk);
       split=0;
       
       
       
    end   
    
endmodule
