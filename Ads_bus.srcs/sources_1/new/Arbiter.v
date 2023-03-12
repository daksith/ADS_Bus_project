`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2023 06:45:04 PM
// Design Name: 
// Module Name: Arbiter
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


module Arbiter(
    input clk,reset,
    
    //master1 io
    input mast1_valid, mast1_type,
    input[1:0] mast1_id,
    input[14:0] mast1_addr,
    input[31:0] mast1_wdata,
    output reg [31:0] mast1_rdata,
    output reg  mast1_ready,
    
    //master2 io
    input mast2_valid, mast2_type,
    input[1:0] mast2_id,
    input[14:0] mast2_addr,
    input[31:0] mast2_wdata,
    output reg [31:0] mast2_rdata,
    output reg  mast2_ready,
    
    //master3 io
    input mast3_valid, mast3_type,
    input[1:0] mast3_id,
    input[14:0] mast3_addr,
    input[31:0] mast3_wdata,
    output reg [31:0] mast3_rdata,
    output reg  mast3_ready,
    
    //slave1 io
    output reg slav1_valid, slav1_type,
    output reg[1:0] slav1_master_id,
    output reg[31:0] slav1_wdata,
    output reg[31:0] slav1_addr,
    input [31:0] slav1_rdata,
    input slav1_ready,
    
    //slave2 io
    output reg slav2_valid, slav2_type,
    output reg[1:0] slav2_master_id,
    output reg[31:0] slav2_wdata,
    output reg[31:0] slav2_addr,
    input [31:0] slav2_rdata,
    input slav2_ready,
    
    //slave3 io
    output reg slav3_valid, slav3_type,
    output reg[1:0] slav3_master_id,
    output reg[31:0] slav3_wdata,
    output reg[31:0] slav3_addr,
    input [31:0] slav3_rdata,
    input slav3_ready,
    input slav3_split
    
    );
    
    `include "aribiter_params.vh"
    
    reg split;
    reg sample_mast_id = 1;
    reg [1:0] split_master_id;
    
    always@(*)
    begin
        //handle master1
        if (mast1_valid==1 & !(split & split_master_id==master1))
            begin
                //connect slave1
                if (mast1_addr[14:12] == slave1)
                    begin
                        slav1_valid = 1;
                        slav1_addr = mast1_addr[11:0];
                        slav1_type = mast1_type;
                        slav1_master_id = mast1_id;
                        slav1_wdata = mast1_wdata;
                        mast1_rdata = slav1_rdata;
                        mast1_ready = slav1_ready;
                    end
                else
                //default case to prevent latching
                    begin
                        slav1_valid = 0;
                        slav1_addr = 0;
                        slav1_type = 0;
                        slav1_master_id = 0;
                        slav1_wdata = 0;
                        mast1_rdata = 0;
                        mast1_ready = 0;
                    end
                    
                //connect slave2
                if (mast1_addr[14:12] == slave2)
                    begin
                        slav2_valid = 1;
                        slav2_addr = mast1_addr[11:0];
                        slav2_type = mast1_type;
                        slav2_master_id = mast1_id;
                        slav2_wdata = mast1_wdata;
                        mast1_rdata = slav2_rdata;
                        mast1_ready = slav2_ready;
                    end
                else
                //default case to prevent latching
                    begin
                        slav2_valid = 0;
                        slav2_addr = 0;
                        slav2_type = 0;
                        slav2_master_id = 0;
                        slav2_wdata = 0;
                        mast1_rdata = 0;
                        mast1_ready = 0;
                    end
                    
                //connect slave3
                if (mast1_addr[14:12] == slave3)
                    begin
                        slav3_valid = 1;
                        slav3_addr = mast1_addr[11:0];
                        slav3_type = mast1_type;
                        slav3_master_id = mast1_id;
                        slav3_wdata = mast1_wdata;
                        mast1_rdata = slav3_rdata;
                        mast1_ready = slav3_ready;
                    end
                else
                //default case to prevent latching
                    begin
                        slav3_valid = 0;
                        slav3_addr = 0;
                        slav3_type = 0;
                        slav3_master_id = 0;
                        slav3_wdata = 0;
                        mast1_rdata = 0;
                        mast1_ready = 0;
                    end                          
                       
            end
            else if (mast2_valid==1 & !(split & split_master_id==master2))
                begin
                //connect slave1
                if (mast2_addr[14:12] == slave1)
                    begin
                        slav1_valid = 1;
                        slav1_addr = mast2_addr[11:0];
                        slav1_type = mast2_type;
                        slav1_master_id = mast2_id;
                        slav1_wdata = mast2_wdata;
                        mast2_rdata = slav1_rdata;
                        mast2_ready = slav1_ready;
                    end
                else
                //default case to prevent latching
                    begin
                        slav1_valid = 0;
                        slav1_addr = 0;
                        slav1_type = 0;
                        slav1_master_id = 0;
                        slav1_wdata = 0;
                        mast2_rdata = 0;
                        mast2_ready = 0;
                    end
                    
                //connect slave2
                if (mast2_addr[14:12] == slave2)
                    begin
                        slav2_valid = 1;
                        slav2_addr = mast2_addr[11:0];
                        slav2_type = mast2_type;
                        slav2_master_id = mast2_id;
                        slav2_wdata = mast2_wdata;
                        mast2_rdata = slav2_rdata;
                        mast2_ready = slav2_ready;
                    end
                else
                //default case to prevent latching
                    begin
                        slav2_valid = 0;
                        slav2_addr = 0;
                        slav2_type = 0;
                        slav2_master_id = 0;
                        slav2_wdata = 0;
                        mast2_rdata = 0;
                        mast2_ready = 0;
                    end
                    
                //connect slave3
                if (mast2_addr[14:12] == slave3)
                    begin
                        slav3_valid = 1;
                        slav3_addr = mast2_addr[11:0];
                        slav3_type = mast2_type;
                        slav3_master_id = mast2_id;
                        slav3_wdata = mast2_wdata;
                        mast2_rdata = slav3_rdata;
                        mast2_ready = slav3_ready;
                    end
                else
                //default case to prevent latching
                    begin
                        slav3_valid = 0;
                        slav3_addr = 0;
                        slav3_type = 0;
                        slav3_master_id = 0;
                        slav3_wdata = 0;
                        mast2_rdata = 0;
                        mast2_ready = 0;
                    end   
                end
            else if (mast3_valid==1 & !(split & split_master_id==master3))
                    begin
                    //connect slave1
                    if (mast3_addr[14:12] == slave1)
                        begin
                            slav1_valid = 1;
                            slav1_addr = mast3_addr[11:0];
                            slav1_type = mast3_type;
                            slav1_master_id = mast3_id;
                            slav1_wdata = mast3_wdata;
                            mast3_rdata = slav1_rdata;
                            mast3_ready = slav1_ready;
                        end
                    else
                    //default case to prevent latching
                        begin
                            slav1_valid = 0;
                            slav1_addr = 0;
                            slav1_type = 0;
                            slav1_master_id = 0;
                            slav1_wdata = 0;
                            mast3_rdata = 0;
                            mast3_ready = 0;
                        end
                        
                    //connect slave2
                    if (mast3_addr[14:12] == slave2)
                        begin
                            slav2_valid = 1;
                            slav2_addr = mast3_addr[11:0];
                            slav2_type = mast3_type;
                            slav2_master_id = mast3_id;
                            slav2_wdata = mast3_wdata;
                            mast3_rdata = slav2_rdata;
                            mast3_ready = slav2_ready;
                        end
                    else
                    //default case to prevent latching
                        begin
                            slav2_valid = 0;
                            slav2_addr = 0;
                            slav2_type = 0;
                            slav2_master_id = 0;
                            slav2_wdata = 0;
                            mast3_rdata = 0;
                            mast3_ready = 0;
                        end
                        
                    //connect slave3
                    if (mast3_addr[14:12] == slave3)
                        begin
                            slav3_valid = 1;
                            slav3_addr = mast3_addr[11:0];
                            slav3_type = mast3_type;
                            slav3_master_id = mast3_id;
                            slav3_wdata = mast3_wdata;
                            mast3_rdata = slav3_rdata;
                            mast3_ready = slav3_ready;
                        end
                    else
                    //default case to prevent latching
                        begin
                            slav3_valid = 0;
                            slav3_addr = 0;
                            slav3_type = 0;
                            slav3_master_id = 0;
                            slav3_wdata = 0;
                            mast3_rdata = 0;
                            mast3_ready = 0;
                        end                  
                end      
            else
            //prevent latching of slave valid signals and master ready signals
            begin
                slav1_valid=0;
                slav2_valid=0;
                slav3_valid=0;
                mast1_ready=0;
                mast2_ready=0;
                mast3_ready=0;
            end
    end
    
    always@(posedge clk or reset)
    begin
    if (~reset)
        begin
        split=0;
        split_master_id=0;
        end
    else
        begin
        split <= slav3_split;
        if (slav3_split==1)
            if (sample_mast_id==1)
                begin
                split_master_id <= slav3_master_id;
                sample_mast_id <= 0;
                end
        else   
            begin
                split_master_id <= 0;
                sample_mast_id <= 1;
            end
        end
    end
endmodule
