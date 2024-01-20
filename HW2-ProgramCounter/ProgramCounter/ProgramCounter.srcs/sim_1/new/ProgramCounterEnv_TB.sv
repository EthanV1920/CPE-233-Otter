`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg
// 
// Create Date: 01/19/2024 07:17:25 PM
// Module Name: ProgramCounterEnv_TB
// Project Name: ProgramCounter
// Target Devices: Basys3
// Description: Test the program counter and multiplexer together.
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

module ProgramCounterEnv_TB();
    // Inputs
    logic ENV_RST_TB;                      
    logic ENV_WE_TB;                       
    logic [31:0] ENV_JALR_TB;              
    logic [31:0] ENV_BRANCH_TB;            
    logic [31:0] ENV_JAL_TB;               
    logic [31:0] ENV_MTVEC_TB;             
    logic [31:0] ENV_MEPC_TB;              
    logic [31:0] ENV_MUX_SELECT_TB;        
    logic ENV_CLK_TB;                      

    // Outputs
    logic [31:0] ENV_PC_COUNT_TB;   
    logic [31:0] ENV_PC_COUNT_INC_TB; //4

    // Logic
    logic pass; // 1 = pass, 0 = fail

    // Instantiate the Program Counter
    ProgramCounterEnv PC(
        .ENV_RST(ENV_RST_TB),
        .ENV_WE(ENV_WE_TB),
        .ENV_JALR(ENV_JALR_TB),
        .ENV_BRANCH(ENV_BRANCH_TB),
        .ENV_JAL(ENV_JAL_TB),
        .ENV_MTVEC(ENV_MTVEC_TB),
        .ENV_MEPC(ENV_MEPC_TB),
        .ENV_MUX_SELECT(ENV_MUX_SELECT_TB),
        .ENV_CLK(ENV_CLK_TB),
        .ENV_PC_COUNT(ENV_PC_COUNT_TB),
        .ENV_PC_COUNT_INC(ENV_PC_COUNT_INC_TB)
    );

    initial begin
        // Initialize Logic 
        ENV_CLK_TB = 0; // Instaintiate clock with 0
        pass = 1;       // Assume pass until fail
        
        // Run Tests
        setup();        // Initialize all inputs with values
        reset();        // Reset the test
        ReadMux();      // Verify Mux woerks properly by reading all inputs
        reset();        // Reset the test
        MaxMux();       // Verify Mux works properly with 32'hffff_ffff values
        reset();        // Reset the test
        MinMux();       // Verify Mux works properly with 32'h0000_0000 values
        reset();        // Reset the test
        ResetTest();    // Verify reset case works on the program counter
        reset();        // Reset the test
        RandNum();      // Verify Mux works properly with random values
        reset();        // Reset the test
        WriteEnable();  // Verify program counter works properly with write enable
        if (pass == 1) $display("All Tests Passed");
        $finish;        // Finish the test


    
    end 

    // Setup all inputs with normal values
    task setup();
        ENV_RST_TB = 0;
        ENV_WE_TB = 1;
        #10
        ENV_RST_TB = 0;
        ENV_JALR_TB = 0;
        ENV_BRANCH_TB = 0;
        ENV_JAL_TB = 0;
        ENV_MTVEC_TB = 0;
        ENV_MEPC_TB = 0;
        ENV_MUX_SELECT_TB = 0;
        $display("Setup Complete");
    endtask // setup

    // Read all inputs to verify mux works properly
    task ReadMux();
        // Load the program counter with the select value multiplied by 10
        ENV_JALR_TB = 32'h0000_0010;
        ENV_MUX_SELECT_TB = 1;
        #10
        // Verify the random number was loaded into the program counter and that the 
        // program counter incremented output was incremented by 4
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0014 || ENV_PC_COUNT_TB != 32'h0000_0010) begin
            $display("JALR Read Failed");
            pass = 0;
        end

        // Repeat for all inputs
        ENV_BRANCH_TB = 32'h0000_0020;
        ENV_MUX_SELECT_TB = 2;
        #10
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0024 || ENV_PC_COUNT_TB != 32'h0000_0020) begin
            $display("BRANCH Read Failed");
            pass = 0;
        end

        ENV_JAL_TB = 32'h0000_0030;
        ENV_MUX_SELECT_TB = 3;
        #10
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0034 || ENV_PC_COUNT_TB != 32'h0000_0030) begin
            $display("JAL Read Failed");
            pass = 0;
        end

        ENV_MTVEC_TB = 32'h0000_0040;
        ENV_MUX_SELECT_TB = 4;
        #10
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0044 || ENV_PC_COUNT_TB != 32'h0000_0040) begin
            $display("MTVEC Read Failed");
            pass = 0;
        end

        ENV_MEPC_TB = 32'h0000_0050;
        ENV_MUX_SELECT_TB = 5;
        #10
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0054 || ENV_PC_COUNT_TB != 32'h0000_0050) begin
            $display("MEPC Read Failed");
            pass = 0;
        end

        // Determine if the test passed or failed
        if (pass == 1) begin
            $display("ReadMux Test Passed");
        end else begin
            $display("ReadMux Test Failed");
        end
        
    endtask // ReadMux


    // Verify the program counter works properly with 32'hffff_ffff values
    task MaxMux();
        // Load the program counter with the max 32bit value
        ENV_JALR_TB = 32'hffff_ffff;
        ENV_MUX_SELECT_TB = 1;
        #10
        // Verify the program counter incremented outputs are correct meaning they are
        // carryed over properly but the address is now incorrect
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0003 || ENV_PC_COUNT_TB != 32'hffff_ffff) begin
            $display("JALR Max Read Failed");
            pass = 0;
        end

        // Repeat for all inputs
        ENV_BRANCH_TB = 32'hffff_ffff;
        ENV_MUX_SELECT_TB = 2;
        #10
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0003 || ENV_PC_COUNT_TB != 32'hffff_ffff) begin
            $display("BRANCH Max Read Failed");
            pass = 0;
        end

        ENV_JAL_TB = 32'hffff_ffff;
        ENV_MUX_SELECT_TB = 3;
        #10
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0003 || ENV_PC_COUNT_TB != 32'hffff_ffff) begin
            $display("JAL Max Read Failed");
            pass = 0;
        end

        ENV_MTVEC_TB = 32'hffff_ffff;
        ENV_MUX_SELECT_TB = 4;
        #10
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0003 || ENV_PC_COUNT_TB != 32'hffff_ffff) begin
            $display("MTVEC Max Read Failed");
            pass = 0;
        end

        ENV_MEPC_TB = 32'hffff_ffff;
        ENV_MUX_SELECT_TB = 5;
        #10
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0003 || ENV_PC_COUNT_TB != 32'hffff_ffff) begin
            $display("MEPC Max Read Failed");
            pass = 0;
        end

        // Determine if the test passed or failed
        if (pass == 1) begin
            $display("MaxMux Test Passed");
        end else begin
            $display("MaxMux Test Failed");
        end
    endtask // maxMux


    // Verify the program counter works properly with 32'h0000_0000 values
    task MinMux();
        // Load the program counter with the min 32bit value
        ENV_JALR_TB = 32'h0000_0000;
        ENV_MUX_SELECT_TB = 1;
        #10
        // Verify the program counter incremented outputs are correct and should lead to
        // another valid address
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0004 || ENV_PC_COUNT_TB != 32'h0000_0000) begin
            $display("JALR Min Read Failed");
            pass = 0;
        end

        // Repeat for all inputs
        ENV_BRANCH_TB = 32'h0000_0000;
        ENV_MUX_SELECT_TB = 2;
        #10
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0004 || ENV_PC_COUNT_TB != 32'h0000_0000) begin
            $display("BRANCH Min Read Failed");
            pass = 0;
        end

        ENV_JAL_TB = 32'h0000_0000;
        ENV_MUX_SELECT_TB = 3;
        #10
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0004 || ENV_PC_COUNT_TB != 32'h0000_0000) begin
            $display("JAL Min Read Failed");
            pass = 0;
        end

        ENV_MTVEC_TB = 32'h0000_0000;
        ENV_MUX_SELECT_TB = 4;
        #10
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0004 || ENV_PC_COUNT_TB != 32'h0000_0000) begin
            $display("MTVEC Min Read Failed");
            pass = 0;
        end

        ENV_MEPC_TB = 32'h0000_0000;
        ENV_MUX_SELECT_TB = 5;
        #10
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0004 || ENV_PC_COUNT_TB != 32'h0000_0000) begin
            $display("MEPC Min Read Failed");
            pass = 0;
        end

        // Determine if the test passed or failed
        if (pass == 1) begin
            $display("MinMux Test Passed");
        end else begin
            $display("MinMux Test Failed");
        end

    endtask // MinMux


    // Verify the program counter works properly with reset
    task ResetTest();
        // Send a reset signal
        ENV_RST_TB = 1;
        #10
        ENV_RST_TB = 0;

        // Verify the program counter was reset to 0
        if (ENV_PC_COUNT_INC_TB != 32'h0000_0004 || ENV_PC_COUNT_TB != 32'h0000_0000) begin
            $display("Reset Test Failed");
            pass = 0;
        end

        // Determine if the test passed or failed
        if (pass == 1) begin
            $display("Reset Test Passed");
        end else begin
            $display("Reset Test Failed");
        end

    endtask // ResetTest

    task RandNum();
        // Load a random number into the program counter
        int rand_num;
        rand_num = $random;
        ENV_JALR_TB = rand_num;
        ENV_MUX_SELECT_TB = 1;
        #10
        // Verify the random number was loaded into the program counter
        if (ENV_PC_COUNT_INC_TB != rand_num + 4 || ENV_PC_COUNT_TB != rand_num) begin
            $display("JALR Rand Read Failed");
            pass = 0;
        end

        // Repeat for all inputs
        rand_num = $random;
        ENV_BRANCH_TB = rand_num;
        ENV_MUX_SELECT_TB = 2;
        #10
        if (ENV_PC_COUNT_INC_TB != rand_num + 4 || ENV_PC_COUNT_TB != rand_num) begin
            $display("BRANCH Rand Read Failed");
            pass = 0;
        end

        rand_num = $random;
        ENV_JAL_TB = rand_num;
        ENV_MUX_SELECT_TB = 3;
        #10
        if (ENV_PC_COUNT_INC_TB != rand_num + 4 || ENV_PC_COUNT_TB != rand_num) begin
            $display("JAL Rand Read Failed");
            pass = 0;
        end

        rand_num = $random;
        ENV_MTVEC_TB = rand_num;
        ENV_MUX_SELECT_TB = 4;
        #10
        if (ENV_PC_COUNT_INC_TB != rand_num + 4 || ENV_PC_COUNT_TB != rand_num) begin
            $display("MTVEC Rand Read Failed");
            pass = 0;
        end

        rand_num = $random;
        ENV_MEPC_TB = rand_num;
        ENV_MUX_SELECT_TB = 5;
        #10
        if (ENV_PC_COUNT_INC_TB != rand_num + 4 || ENV_PC_COUNT_TB != rand_num) begin
            $display("MEPC Rand Read Failed");
            pass = 0;
        end

        if (pass == 1) begin
            $display("RandNum Test Passed");
        end else begin
            $display("RandNum Test Failed");
        end
    endtask // RandNum 

    task WriteEnable();
        // Load a random number into the program counter
        int rand_num;
        rand_num = $random;
        ENV_JALR_TB = rand_num; // Load the random number into the JALR 
        ENV_MUX_SELECT_TB = 1;
        ENV_WE_TB = 1;          // Enable the write
        #10
        // Verify the random number was loaded into the program counter
        if (ENV_PC_COUNT_INC_TB != rand_num + 4 || ENV_PC_COUNT_TB != rand_num) begin
            $display("JALR Write Failed");
            pass = 0;
        end

        ENV_WE_TB = 0;          // Disable the write
        ENV_JALR_TB = 0;        // Reset the JALR
        #10
        // Verify the 0 was not loaded into the program counter
        if (ENV_PC_COUNT_INC_TB != rand_num + 4 || ENV_PC_COUNT_TB != rand_num) begin
            $display("JALR Write Disable Failed");
            pass = 0;
        end

        if (pass == 1) begin
            $display("WriteEnable Test Passed");
        end else begin
            $display("WriteEnable Test Failed");
        end
    endtask // WriteEnable


    // Reset the test
    task reset();
        ENV_RST_TB = 1;
        #10
        ENV_RST_TB = 0;
    endtask // reset
    
    // Toggle Clock
    always #5 ENV_CLK_TB = ~ENV_CLK_TB;

endmodule
