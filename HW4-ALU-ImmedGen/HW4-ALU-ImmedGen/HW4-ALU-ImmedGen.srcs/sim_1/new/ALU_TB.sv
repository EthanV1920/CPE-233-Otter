`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg
// 
// Create Date: 02/02/2024 08:04:37 PM
// Module Name: ALU_TB
// Project Name: Arithmetic Logic Unit
// Target Devices: Basys 3
// Description: This is a test bench for the ALU module
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_TB();
    // Inputs
    logic [31:0] srcA_TB;          // 32-bit input A
    logic [31:0] srcB_TB;          // 32-bit input B
    logic [3:0] operation_TB;      // 5-bit function code

    // Outputs
    logic [31:0] result_TB;  // 32-bit result

    // Testing Logic 
    logic pass = 1; // 1 = pass, 0 = fail

    // Testing Array
    const int testArraySize = 99;
    logic [31:0] testArray [0:98];

    // Instantiate the Unit Under Test (UUT)
    ALU uut (
        .srcA(srcA_TB), 
        .srcB(srcB_TB), 
        .operation(operation_TB), 
        .result(result_TB)
    );

    initial begin
    // string filename = "aluVerification.txt";
    // int file = $fopen(filename, "r");
    // if (file == 0) begin
    //     $display("Error: Failed to open file %s", filename);
    // end else begin
    //     $fclose(file);
    // end
    string filename = "aluVerification.mem";
    $readmemh(filename, testArray);

    for (int i = 0; i < testArraySize; i +=3) begin
        operation_TB = testArray[i][3:0];
        srcA_TB = testArray[i+1];
        srcB_TB = testArray[i+2];
        #10 // Wait for result_TB to be updated

        // Display values for debugging and verification
        // $display("srcA_TB: %h", srcA_TB);
        // $display("srcB_TB: %h", srcB_TB);
        // $display("operation_TB: %h", operation_TB);
        // $display("result_TB: %h", result_TB);
        $display("srcA: %h | srcB: %h | operation: %h | result: %h", srcA_TB, srcB_TB, operation_TB, result_TB);
        // $display("%h", result_TB);
    
    end
    $finish;


    end

endmodule
