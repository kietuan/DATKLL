module simulation;
    reg terminate_interrupt_button = 0;
    reg SYS_reset, SYS_start_button, clk;
    
    reg [7:0]   input_ins;
    reg [7:0]   input_data;
    reg         write_instruction_request;
    reg         write_data_request;

    wire        inst_to_CPU_valid;
    wire [7:0]  inst_to_CPU;
    wire        data_to_CPU_valid;
    wire [7:0]  data_to_CPU;

    wire        CPU_execute_enable;
    wire        CPU_finish_execution;
    wire        CPU_read_request = ~CPU_execute_enable;

    wire        DMEM_transmit_request;
    wire [7:0]  DMEM_data_transmit;
    wire [31:0] DMEM_data_transmit_address;

    wire        transmitter_buffer_full, transmitter_buffer_empty;


    wire        data_fromCPU_valid;
    wire [7:0]  data_fromCPU;   // to tx

    reg         transmitter_request = 1;



    reg [31:0] instruction [0:99];
    reg [7:0] data [0:15];
    integer ins_index, data_index, i;

    initial
    begin
        $readmemh("C:/Users/tuankiet/Desktop/input_text.txt", instruction);
        $readmemh("C:/Users/tuankiet/Desktop/input_data.txt", data);

        ins_index                       = 0;
        data_index                      = 0;
        i                               = 0;
        write_instruction_request       = 0;
        write_data_request              = 0;
        SYS_start_button                = 0;
        SYS_reset                       = 1;
        #1.1 SYS_reset                  = 0;
        #1.5 write_instruction_request  = 1;

        for (ins_index = 0; ins_index <= 99; ins_index = ins_index + 1)
            for (i = 24; i >= 0; i = i - 8)
            begin
                input_ins = instruction[ins_index][i +: 8];
                #1.0;
            end
            
        
        write_instruction_request = 0;
        write_data_request        = 1;

        for (data_index = 0; data_index <= 15; data_index = data_index + 1)
        begin
            input_data = data[data_index];
            #1.0;
        end
        write_data_request = 0;
        #5.0 SYS_start_button = 1;
    end

    initial
    begin //test
        #0.5 clk = 0;
        forever #0.5 clk = ~clk;
    end 


    fifo_buffer receive_data_buffer
    (
        //INPUT
        .clk            (clk),
        .SYS_reset      (SYS_reset), 
        .write_request  (write_data_request), 
        .data_in        (input_data), 
        .read_request   (CPU_read_request),

        //OUTPUT
        .data_valid     (data_to_CPU_valid),
        .data_out       (data_to_CPU)
    );;

    fifo_buffer receive_instruction_buffer 
    (
        //INPUT
        .clk            (clk),
        .SYS_reset      (SYS_reset), 
        .write_request  (write_instruction_request), 
        .data_in        (input_ins), 
        .read_request   (CPU_read_request),

        //OUTPUT
        .data_valid     (inst_to_CPU_valid),
        .data_out       (inst_to_CPU)
    );

    
    RISCV_CPU RISCV_CPU
    (
        //INPUT
        .clk                    (clk),
        .SYS_reset              (SYS_reset),
        .SYS_start_button       (SYS_start_button),
        .terminate_interrupt_button(terminate_interrupt_button),
        
        .inst_to_CPU_valid      (inst_to_CPU_valid),
        .inst_to_CPU            (inst_to_CPU),
        .data_to_CPU_valid      (data_to_CPU_valid),
        .data_to_CPU            (data_to_CPU),
        .transmitter_buffer_full(transmitter_buffer_full),

        //OUTPUT
        .DMEM_transmit_request  (DMEM_transmit_request),
        .DMEM_data_transmit     (DMEM_data_transmit),
        .DMEM_transmit_address  (DMEM_data_transmit_address),
        .CPU_finish_execution   (CPU_finish_execution),
        .CPU_execute_enable     (CPU_execute_enable)
    );

    fifo_buffer transmit_data_buffer
    (
        //INPUT
        .clk            (clk),
        .SYS_reset      (SYS_reset), 
        .write_request  (DMEM_transmit_request), 
        .data_in        (DMEM_data_transmit), 
        .read_request   (transmitter_request),

        //OUTPUT
        .full           (transmitter_buffer_full), 
        .empty          (transmitter_buffer_empty),
        .data_valid     (data_fromCPU_valid),
        .data_out       (data_fromCPU)
    );
endmodule
