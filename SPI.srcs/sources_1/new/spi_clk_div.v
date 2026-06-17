`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/15/2026 10:15:41 PM
// Design Name: 
// Module Name: spi_clk_div
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


module spi_clk_div(
    input sys_clk,
    input sys_rst_n,
    input [7:0] clk_div,
    input en,
    output reg fall_en,
    output reg rise_en
    );
    
    reg [7:0] counter;
    
    always@(posedge sys_clk) begin
        if(!sys_rst_n) begin
            counter <= 8'b0;
            fall_en <= 1'b0;
            rise_en <= 1'b0;
        end else if (!en) begin
            counter <= 8'b0;
            fall_en <= 1'b0;
            rise_en <= 1'b0;
        end else begin
            fall_en <= 1'b0;
            rise_en <= 1'b0;
            if(counter == clk_div) begin
                fall_en <= 1'b1;
                counter <= 8'b0;
            end else begin
                if(counter == clk_div >> 1) begin
                    rise_en <= 1'b1;
                end
                counter <= counter + 1;
           end
       end
   end
endmodule
