`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg
// 
// Create Date: 01/26/2024 11:06:16 PM
// Module Name: RegFile_TB
// Project Name: RegFile
// Target Devices: Basys 3
// Description: This Testbench tests the RegFile module
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module RegFile_TB();

    // Inputs
    logic ENABLE_TB;        // 1-bit enable
    logic CLK_TB = 0;       // 1-bit clock
    logic [4:0] ADR1_TB;    // 5-bit address
    logic [4:0] ADR2_TB;    // 5-bit address
    logic [4:0] WADR_TB;    // 5-bit address
    logic [31:0] WDATA_TB;  // 32-bit data

    // Outputs
    logic [31:0] RS1_TB;    // 32-bit data
    logic [31:0] RS2_TB;    // 32-bit data

    // Logic
    logic passed = 1;       // 1 = pass, 0 = fail
    logic simPage = 1;      // 1 = simPage, 0 = no simPage

    // Define Clock
    always #5 CLK_TB = ~CLK_TB;
    
    // Define Clock
    always #70 simPage = ~simPage;

    // Instantiate the Unit Under Test (UUT)
    RegFile uut (
        .ENABLE(ENABLE_TB), 
        .CLK(CLK_TB), 
        .ADR1(ADR1_TB), 
        .ADR2(ADR2_TB), 
        .WADR(WADR_TB), 
        .WDATA(WDATA_TB), 
        .RS1(RS1_TB), 
        .RS2(RS2_TB)
    );

    // Begin simulation code
    initial begin

        $display("----------------------------------------\n");
        $display("RegFile Testbench\n");
        $display("----------------------------------------\n");

        setup();            // Setup Task   
        randomBits();       // Random bits Task
        zeroBits();         // Zero bits Task
        enableWrite();      // Enable Write Task
        minBits();          // Min bits Task
        maxBits();          // Max bits Task

        // Display overall pass/fail
        $display("----------------------------------------\n");
        if (passed == 1) begin
            $display("OVERALL PASS\n");
        end else begin
            $display("OVERALL FAIL\n");
        end 
        $display("----------------------------------------\n");
        $finish;
    end

    task setup();
        // Initialize Logic
        ENABLE_TB = 0;      // Initialize ENABLE_TB
        ADR1_TB = 0;        // Initialize ADR1_TB
        ADR2_TB = 0;        // Initialize ADR2_TB
        WADR_TB = 0;        // Initialize WADR_TB
        WDATA_TB = 0;       // Initialize WDATA_TB
        RS1_TB = 0;         // Initialize RS1_TB
        RS2_TB = 0;         // Initialize RS2_TB

        $display("Setup Complete");

    endtask

    task randomBits();
        // Random bits
        logic [31:0] testBits [0:31];


        //enable write input
        ENABLE_TB = 32'h0000_0001;

        // Load Random Bits
        for (int i = 0; i < 31; i++) begin
            testBits[i] = $random;
            WADR_TB = i;
            WDATA_TB = testBits[i];
            #10;
            // Display Case
            // $display("WADR_TB[%0d] = %h", i, WADR_TB);
        end 

        // Read random bits
        // Check x0 returns 0
        if (RS1_TB != 32'h0000_0000) begin
            $display("Error: x0 test RS1_TB[%0d] = %h", 0, RS1_TB);
            $display("Error: x0 test testBits[%0d] = %h", 0, testBits[0]);
            passed = 0;
        end
        // Check x0 returns 0   
        if (RS2_TB != 32'h0000_0000) begin
            $display("Error: x0 test RS2_TB[%0d] = %h", 0, RS2_TB);
            $display("Error: x0 test testBits[%0d] = %h", 0, testBits[0]);
            passed = 0;
        end


        for (int i = 1; i < 31; i++) begin
            // Set ADR1 and ADR2 to i and allow for propagation
            ADR1_TB = i;
            ADR2_TB = i;
            #10;

            // Check RS1 returns expecred value
            if (RS1_TB != testBits[i]) begin
                $display("Error: Random Read Test RS1_TB[%0d] = %h", i, RS1_TB);
                $display("Error: Random Read Test testBits[%0d] = %h", i, testBits[i]);
                passed = 0;
            end

            // Check RS2 returns expecred value
            if (RS2_TB != testBits[i]) begin
                $display("Error: Random Read Test RS2_TB[%0d] = %h", i, RS2_TB);
                $display("Error: Random Read Test testBits[%0d] = %h", i, testBits[i]);
                passed = 0;
            end
            #10;

            // Display Case
            // $display("ADR1_TB[%0d] = %h", i, ADR1_TB);
            // $display("ADR2_TB[%0d] = %h", i, ADR2_TB);
        end

        if (passed == 1) begin
            $display("Random Bits Test Passed");
        end else begin
            $display("Random Bits Test Failed");
        end

    endtask

    // Task to test zero bits
    task zeroBits();
        //enable write input
        ENABLE_TB = 32'h0000_0001;

        WADR_TB = 0;
        WDATA_TB = 32'h0000_0000;
        ADR1_TB = 0;
        ADR2_TB = 0;
        #10;

        // Load Zero Bits
        // Check x0 returns 0
        if (RS1_TB != 32'h0000_0000) begin
            $display("Error: x0 Load All Zeros RS1");
            passed = 0;
        end
        // Check x0 returns 0   
        if (RS2_TB != 32'h0000_0000) begin
            $display("Error: x0 Load All Zeros RS2");
            passed = 0;
        end
        
        
        WADR_TB = 0;
        WDATA_TB = 32'hffff_ffff;
        ADR1_TB = 0;
        ADR2_TB = 0;
        #10;

        // Load Zero Bits
        // Check x0 returns 0
        if (RS1_TB != 32'h0000_0000) begin
            $display("Error: x0 Load All F RS1");
            passed = 0;
        end
        // Check x0 returns 0   
        if (RS2_TB != 32'h0000_0000) begin
            $display("Error: x0 Load All F RS2");
            passed = 0;
        end

        if (passed == 1) begin
            $display("Zero Bits Test Passed");
        end else begin
            $display("Zero Bits Test Failed");
        end

    endtask

    // Max Bits Task

    task maxBits();
        //enable write input
        ENABLE_TB = 32'h0000_0001;

        // Load Max Bits
        for (int i = 0; i < 31; i++) begin
            WADR_TB = i;
            WDATA_TB = 32'hffff_ffff;
            #10;
            // Display Case
            // $display("WADR_TB[%0d] = %h", i, WADR_TB);
        end 

        // Read Max bits
        for (int i = 1; i < 31; i++) begin
            // Set ADR1 and ADR2 to i and allow for propagation
            ADR1_TB = i;
            ADR2_TB = i;
            #10;

            // Check RS1 returns expecred value
            if (RS1_TB != 32'hffff_ffff) begin
                $display("Error: Max Read Test RS1_TB[%0d] = %h", i, RS1_TB);
                passed = 0;
            end

            // Check RS2 returns expecred value
            if (RS2_TB != 32'hffff_ffff) begin
                $display("Error: Max Read Test RS2_TB[%0d] = %h", i, RS2_TB);
                passed = 0;
            end
            #10;

            // Display Case
            // $display("ADR1_TB[%0d] = %h", i, ADR1_TB);
            // $display("ADR2_TB[%0d] = %h", i, ADR2_TB);
        end

        if (passed == 1) begin
            $display("Max Bits Test Passed");
        end else begin
            $display("Max Bits Test Failed");
        end

    endtask

    task minBits();
        //enable write input
        ENABLE_TB = 32'h0000_0001;

        // Load Min Bits
        for (int i = 0; i < 31; i++) begin
            WADR_TB = i;
            WDATA_TB = 32'h0000_0000; // Write minimum value
            #10;
            // Display Case
            // $display("WADR_TB[%0d] = %h", i, WADR_TB);
        end 

        // Read Min bits
        for (int i = 1; i < 31; i++) begin
            // Set ADR1 and ADR2 to i and allow for propagation
            ADR1_TB = i;
            ADR2_TB = i;
            #10;

            // Check RS1 returns expected value
            if (RS1_TB != 32'h0000_0000) begin // Check for minimum value
                $display("Error: Min Read Test RS1_TB[%0d] = %h", i, RS1_TB);
                passed = 0;
            end

            // Check RS2 returns expected value
            if (RS2_TB != 32'h0000_0000) begin // Check for minimum value
                $display("Error: Min Read Test RS2_TB[%0d] = %h", i, RS2_TB);
                passed = 0;
            end
            #10;

            // Display Case
            // $display("ADR1_TB[%0d] = %h", i, ADR1_TB);
            // $display("ADR2_TB[%0d] = %h", i, ADR2_TB);
        end

        if (passed == 1) begin
            $display("Min Bits Test Passed");
        end else begin
            $display("Min Bits Test Failed");
        end

    endtask

    //Enable Write Task
    task enableWrite();
        // Random bits
        logic [31:0] testBits [0:31];

        //enable write input
        ENABLE_TB = 32'h0000_0001;

        // Load Random Bits
        for (int i = 0; i < 31; i++) begin
            testBits[i] = $random;
            WADR_TB = i;
            WDATA_TB = testBits[i];
            #10;
            // Display Case
            // $display("WADR_TB[%0d] = %h", i, WADR_TB);
        end 

        // Disable write input
        ENABLE_TB = 32'h0000_0000;
        #10

        // Attempt to zero out registers
        for (int i = 0; i < 31; i++) begin
            WADR_TB = i;
            WDATA_TB = 32'h0000_0000; // Write minimum value
            #10;
            // Display Case
            // $display("WADR_TB[%0d] = %h", i, WADR_TB);
        end 

        for (int i = 1; i < 31; i++) begin
            // Set ADR1 and ADR2 to i and allow for propagation
            ADR1_TB = i;
            ADR2_TB = i;
            #10;

            // Check RS1 returns expecred value
            if (RS1_TB != testBits[i]) begin
                $display("Error: Enable Bits Test RS1_TB[%0d] = %h", i, RS1_TB);
                $display("Error: Enable Bits Test testBits[%0d] = %h", i, testBits[i]);
                passed = 0;
            end

            // Check RS2 returns expecred value
            if (RS2_TB != testBits[i]) begin
                $display("Error: Enable Bits Test RS2_TB[%0d] = %h", i, RS2_TB);
                $display("Error: Enable Bits Test testBits[%0d] = %h", i, testBits[i]);
                passed = 0;
            end
            #10;

            // Display Case
            // $display("ADR1_TB[%0d] = %h", i, ADR1_TB);
            // $display("ADR2_TB[%0d] = %h", i, ADR2_TB);
        end

        if (passed == 1) begin
            $display("Enable Write Test Passed");
        end else begin
            $display("Enable Write Test Failed");
        end

    endtask


endmodule
