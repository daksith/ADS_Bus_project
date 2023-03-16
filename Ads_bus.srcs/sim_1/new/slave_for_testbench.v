`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2023 07:42:40 PM
// Design Name: 
// Module Name: slave_for_testbench
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


module slave_for_testbench(
    input slav_valid, slav_type,
    input[1:0] slav_master_id,
    input[31:0] slav_wdata,
    input[11:0] slav_addr,
    output reg[31:0] slav_rdata,
    input slav_ready,
    input clk
    );
    `include "aribiter_params.vh"
    
    reg[31:0] data[4095:0];
    
    always@(posedge clk)
    begin
    if (slav_valid==1 & slav_type==write & slav_ready)
        data[slav_addr]<=slav_wdata;
    end
    
    always@(*)
    begin
        if (slav_valid==1 & slav_type==read & slav_ready)
            slav_rdata = data[slav_addr];
        else
            slav_rdata = 0;  
    end
    
endmodule
