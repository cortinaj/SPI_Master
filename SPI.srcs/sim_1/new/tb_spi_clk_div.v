`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 06:44:14 PM
// Design Name: 
// Module Name: tb_spi_clk_div
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


module tb_spi_clk_div();
    //Initialize wires and reg
    reg sys_clk_tb;
    reg sys_rst_n_tb;
    reg [7:0] clk_div_tb;
    reg en_tb;
    wire fall_en_tb;
    wire rise_en_tb;
    
    //Instantiate clock divider dut   
    spi_clk_div dut(.sys_clk(sys_clk_tb),
                    .sys_rst_n(sys_rst_n_tb),
                    .clk_div(clk_div_tb),
                    .en(en_tb),
                    .fall_en(fall_en_tb),
                    .rise_en(rise_en_tb)
                    );
    // Add clock generator
    initial sys_clk_tb = 0;
    always #10 sys_clk_tb = ~sys_clk_tb;               
    
    //Start Test
    initial begin
    //Initialize all inputs
    sys_rst_n_tb = 0;
    en_tb = 0;
    clk_div_tb = 8'd0;
    
    //Test 1: Reset Behavior
    repeat(5) @(posedge sys_clk_tb);
    
    if(fall_en_tb !== 0 || rise_en_tb !== 0) begin
        $display("FAIL: outputs are not zero during reset");
    end else begin
        $display("Pass: outputs are zero during reset");
    end
    
    @(posedge sys_clk_tb);
    sys_rst_n_tb = 1;
    @(posedge sys_clk_tb);
    if(fall_en_tb !== 0 || rise_en_tb !== 0) begin
        $display("FAIL: outputs are not zero immediately after reset");
    end else begin
        $display("Pass: outputs are zero immediately after reset");
    end
    
    //Test 2 Pulse timing test with clk_div = 2
    clk_div_tb = 8'd2;
    en_tb = 1;
    repeat(20)@(posedge sys_clk_tb);
    $display("INFO: exepcted SCLK eriod = %0d ns", 2 * (2+1) * 20);
    
    //Test 3 Deassert enable
    en_tb = 0;
    repeat(10)@(posedge sys_clk_tb);
    
    if(fall_en_tb !== 0 || rise_en_tb !== 0) begin
        $display("FAIL: pulses are not suppressed when en = 0");
    end else begin
        $display("Pass: pulses are suppressed when en = 0");
    end
      
    end 
endmodule
