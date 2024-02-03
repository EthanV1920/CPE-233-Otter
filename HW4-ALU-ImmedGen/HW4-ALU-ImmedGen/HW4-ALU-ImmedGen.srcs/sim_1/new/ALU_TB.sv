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
    const int testArraySize = 14;
    logic [31:0] testArray [0:13];

    initial begin
    // string filename = "aluVerification.txt";
    // int file = $fopen(filename, "r");
    // if (file == 0) begin
    //     $display("Error: Failed to open file %s", filename);
    // end else begin
    //     $fclose(file);
    // end
    string filename = "Z:/Documents/git/CPE-233-Otter/HW4-ALU-ImmedGen/HW4-ALU-ImmedGen/HW4-ALU-ImmedGen.srcs/sources_1/imports/HW4-ALU-ImmedGen/aluVerification.txt";
    int file = $fopen(filename, "r");
    if (file == 0) begin
        $display("Error: Failed to open file %s", filename);
    end else begin
        string line;
        int i = 0;
        while (!$feof(file) && i < testArraySize) begin
            if ($fgets(line, file)) begin
                $display("line: %s", line);
                testArray[i] = {27'b0, $shortrealtobits(line)};
                i = i + 1;
                // $display("testArray[%0d]: %h", i, testArray[i]);
            end
        end
        $fclose(file);
    end

    end

endmodule
