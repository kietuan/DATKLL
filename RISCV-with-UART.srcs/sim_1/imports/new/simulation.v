module simulation
(
);

    reg SYS_reset, SYS_start_button, CPU_clk;
    reg IO_clk;
    reg [7:0] input_ins;
    reg        write_toMEM_request;
    wire       receive_buffer_full, receive_buffer_empty;
    wire       PC_data_valid;
    wire [7:0] PC_data;  

    wire [31:0] instruction;
    wire        execution_enable;
    wire        stop_execution;
    wire       IMEM_write_request = ~execution_enable;

    wire       DMEM_transmit_request;
    wire [7:0] DMEM_data_transmit;

    wire       transmitter_buffer_full;

    reg        transmitter_request = 1;

    wire       data_fromMem_valid;
    wire [7:0] data_fromMem;   // to tx

    initial
    begin //test
        #0.5 CPU_clk = 0;
        forever #0.5 CPU_clk = ~CPU_clk;
    end 

    initial begin
        IO_clk = 0;
        forever #1 IO_clk = ~IO_clk;
    end

    initial 
    begin
        SYS_reset       = 1;
        #10 SYS_reset  = 0;

        write_toMEM_request = 0;
        SYS_start_button    = 0;

        #3.0 write_toMEM_request = 1;
             input_ins =  'hff;
        #2.0 input_ins =  'h60;
        #2.0 input_ins =  'h01;
        #2.0 input_ins =  'h93;

        #2.0 input_ins =  'h0f;
        #2.0 input_ins =  'hc1;
        #2.0 input_ins =  'h00;
        #2.0 input_ins =  'h97;

        #2.0 input_ins =  'hfe;
        #2.0 input_ins =  'h30;
        #2.0 input_ins =  'hae;
        #2.0 input_ins =  'h23;

        #2.0 write_toMEM_request = 0;

        #5.0 SYS_start_button = 1;
    end

    initial begin
        #70 $finish;
    end

    fifo_buffer Receiver_to_mem_buffer (
        .writer_clock   (IO_clk), 
        .reader_clock   (CPU_clk),
        .SYS_reset      (SYS_reset), 
        .write_request  (write_toMEM_request), 
        .data_in        (input_ins), 
        .read_request   (IMEM_write_request),
        .full           (receive_buffer_full), 
        .empty          (receive_buffer_empty),
        .data_valid     (PC_data_valid),
        .data_out       (PC_data)
    );


    fifo_buffer mem_to_Transmitter_buffer
    (
        .writer_clock   (CPU_clk), 
        .reader_clock   (IO_clk),
        .SYS_reset      (SYS_reset), 
        .write_request  (DMEM_transmit_request), 
        .data_in        (DMEM_data_transmit), 
        .read_request   (transmitter_request),
        .full           (transmitter_buffer_full), 
        .empty          (),
        .data_valid     (data_fromMem_valid),
        .data_out       (data_fromMem)
    );

    RISCV_CPU RISCV_CPU
    (
        .clk                    (CPU_clk),
        .SYS_reset              (SYS_reset),
        .SYS_start_button       (SYS_start_button),

        .PC_data_valid          (PC_data_valid),
        .PC_data                (PC_data),
        .transmitter_buffer_full(transmitter_buffer_full),
        .DMEM_transmit_request  (DMEM_transmit_request),
        .DMEM_data_transmit     (DMEM_data_transmit),
        .instruction            (instruction),
        .CPU_executing          (CPU_executing),
        .stop_execution         (stop_execution)
    );

endmodule

module buffer_simulation
(
);

    reg SYS_reset, clk;

    reg write_request;
    reg [7:0] data_in = -2;

    reg read_request = 0;
    
    wire buffer_empty, buffer_full;
    wire data_valid;
    wire [7:0] data_out;

    initial
    begin //test
        clk = 0;
        forever #0.5 clk = ~clk;
    end 

    initial 
    begin
        SYS_reset       = 1;
        #0.6 SYS_reset  = 0;
    end

    integer i;
    initial 
    begin
        read_request = 0;

        for (i = 0; i <= 35; i = i + 1)
        begin
            #1 write_request = 1;
            data_in = data_in + 1;
        end
        #1 write_request = 0;

        read_request = 1;
    end

    initial #100 $finish;

    fifo_buffer buffer
    (
        .clk            (clk), 
        .SYS_reset      (SYS_reset), 
        .write_request  (write_request), 
        .data_in        (data_in), 
        .read_request   (read_request),
        .full           (buffer_full), 
        .empty          (buffer_empty),
        .data_valid     (data_valid),
        .data_out       (data_out)
    );



endmodule