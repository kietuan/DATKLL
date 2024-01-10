`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2024 09:40:13 AM
// Design Name: 
// Module Name: test_clock
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


module test_clock
(
    input SYS_clk,

    output reg led,
    output clk_locked
);

    wire clk_5;
    wire gnd = 0;

    clock_wrapper clock_generator
    (
        .sys_clock  (SYS_clk),
        .clk_5mhz   (clk_5),
        .clk_locked (clk_locked)
    );

    reg [63:0] counter;

    always @(posedge clk_5)
    begin
        if (counter >= 10_000_000)
        begin
            led <= ~led;
            counter <= 0;
        end
        else
        begin
            counter <= counter + 1;      
        end
    end

endmodule
