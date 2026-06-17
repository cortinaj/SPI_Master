`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 07:26:50 PM
// Design Name: 
// Module Name: spi_shift_reg
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


module spi_shift_reg(
    input sys_clk,
    input sys_rst_n,
    input fall_en,
    input rise_en,
    input load,
    input [15:0] tx_data,
    input miso,
    input latch_rx,
    output reg mosi,
    output reg [15:0] rx_data
    );
    
    reg[15:0] tx_shift_reg;
    reg[15:0] rx_shift_reg;
    
    always @(posedge sys_clk) begin
        if(!sys_rst_n) begin
            tx_shift_reg <= 16'b0;
            rx_shift_reg <= 16'b0;
            rx_data <= 16'b0;
        end else begin
            if(load) begin
                tx_shift_reg <= tx_data;
            end else if(fall_en)begin
                tx_shift_reg <= tx_shift_reg << 1;
            end
            if(rise_en) begin
                rx_shift_reg <= {rx_shift_reg[14:0],miso};
            end 
            if(latch_rx) begin
                rx_data <= rx_shift_reg;
            end
        end
    end
    
    always @(*) begin
        mosi = tx_shift_reg[15];
    end
                
endmodule
