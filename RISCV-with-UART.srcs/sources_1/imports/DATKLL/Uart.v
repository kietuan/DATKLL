module TOP
(
    input SYS_clk,
    input SYS_reset,
    input SYS_start_button,
    input terminate_interrupt_button,

    input rx,

    input INS_DATA_sw,
    
    // tx interface
    output tx,
    output clk_locked,
    output CPU_executing,
    output CPU_finish_execution
);
    wire clk_5;

    wire       receive_buffer_full, receive_buffer_empty;
    wire       rxDone; 
    wire       txDone;
    
    wire [7:0] toMem;   // from rx
    wire [7:0] data_fromMem;   // to tx
    wire       PC_data_valid;
    wire [7:0] PC_data;  

    wire       IMEM_write_request = ~CPU_executing;
    wire       data_fromMem_valid;
    wire       transmitter_request;
    wire       transmitter_buffer_full, transmitter_buffer_empty;
    wire       DMEM_transmit_request;
    wire [7:0] DMEM_data_transmit;
    

    clock_wizard_wrapper clock_generator
    (   
        //INPUT
        .sys_clock  (SYS_clk),

        //OUTPUT
        .clk_5mhz   (clk_5),
        .clk_locked (clk_locked)
    );


    Receiver Rx 
    (   
        //INPUT
        .clk        (clk_5), 
        .rx         (rx), 
        .SYS_reset  (SYS_reset), 

        //OUTPUT
        .data_out   (toMem), 
        .rxDone     (rxDone)
    );


    fifo_buffer Receiver_to_mem_buffer 
    (
        //INPUT
        .clk            (clk_5),
        .SYS_reset      (SYS_reset), 
        .write_request  (rxDone), 
        .data_in        (toMem), 
        .read_request   (IMEM_write_request),

        //OUTPUT
        .full           (receive_buffer_full), 
        .empty          (receive_buffer_empty),
        .data_valid     (PC_data_valid),
        .data_out       (PC_data)
    );

    
    RISCV_CPU RISCV_CPU
    (
        //INPUT
        .clk                    (clk_5),
        .SYS_reset              (SYS_reset),
        .SYS_start_button       (SYS_start_button),
        .terminate_interrupt_button(terminate_interrupt_button),
        
        .PC_data_valid          (PC_data_valid),
        .PC_data                (PC_data),
        .transmitter_buffer_full(transmitter_buffer_full),

        //OUTPUT
        .DMEM_transmit_request  (DMEM_transmit_request),
        .DMEM_data_transmit     (DMEM_data_transmit),
        .CPU_finish_execution   (CPU_finish_execution),
        .CPU_executing          (CPU_executing)
    );

    fifo_buffer mem_to_Transmitter_buffer
    (
        //INPUT
        .clk            (clk_5),
        .SYS_reset      (SYS_reset), 
        .write_request  (DMEM_transmit_request), 
        .data_in        (DMEM_data_transmit), 
        .read_request   (transmitter_request),

        //OUTPUT
        .full           (transmitter_buffer_full), 
        .empty          (transmitter_buffer_empty),
        .data_valid     (data_fromMem_valid),
        .data_out       (data_fromMem)
    );

    Transmitter Tx 
    (
        //INPUT
        .clk            (clk_5), 
        .SYS_reset      (SYS_reset), 
        .buffer_empty   (transmitter_buffer_empty),
        .data_in        (data_fromMem), 
        .data_valid     (data_fromMem_valid),

        //OUTPUT
        .data_requesting(transmitter_request),
        .tx             (tx), 
        .txDone         (txDone)
    );
endmodule