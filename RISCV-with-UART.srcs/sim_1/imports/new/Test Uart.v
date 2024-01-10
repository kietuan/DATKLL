`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Tuan Kiet
// 
// Create Date: 01/09/2024 03:07:31 PM
// Module Name: test_uart
// Target Devices: Arty Z7
// Description: this module is used to test the UART transmiter and receiver with buffer only,
//              not include RISC-V
// Dependencies: 
// 
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////



module test_uart
(
    input SYS_clk, SYS_reset,

    // rx interface
    input rx,
    
    // tx interface
    output tx,

    output clk_locked,

    output reg  received,
    output      buffer_full, 
    output      buffer_empty

);

    wire       receive_data_valid;

    

    wire clk_5;
    wire gnd = 0;

    wire [7:0] receive_data;


    wire [7:0]  buffer_data;
    wire        buffer_data_valid;
    wire transmitter_request;

    clock_wrapper clock_generator
    (
        .sys_clock  (SYS_clk),
        .clk_5mhz   (clk_5),
        .clk_locked (clk_locked)
    );


    Receiver Rx 
    (
        .clk        (clk_5), 
        .rx         (rx), 
        .SYS_reset  (SYS_reset), 
        .data_out   (receive_data), 
        .rxDone     (receive_data_valid)
    );


    always @(posedge clk_5)
    begin
        if (SYS_reset)               received <= 1;
        else if (receive_data_valid) received <= 0; 
    end

    fifo_buffer buffer
    (
        .clk            (clk_5),
        .SYS_reset      (SYS_reset), 
        .write_request  (receive_data_valid), 
        .data_in        (receive_data), 
        .empty          (buffer_empty),
        .full           (buffer_full),
        .read_request   (transmitter_request),
        .data_valid     (buffer_data_valid),
        .data_out       (buffer_data)
    );
    
    Transmitter Tx 
    (
        .clk            (clk_5), 
        .SYS_reset      (SYS_reset), 

        .buffer_empty   (buffer_empty),
        .data_in        (buffer_data), 
        .data_valid     (buffer_data_valid),
        
        .data_requesting(transmitter_request),
        .tx             (tx)
    );
endmodule
