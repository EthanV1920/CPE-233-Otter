`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg
// 
// Create Date: 02/02/2024 05:45:57 PM
// Module Name: ImmdGen_TB
// Project Name: Immediate Generator Test Bench
// Target Devices: Basys 3
// Description: This is the test bench for the immediate generator module
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module ImmdGen_TB();
    // Inputs
    logic [31:0] instruction_TB; // 32-bit instruction

    // Outputs
    logic [31:0] uTypeImmd_TB;
    logic [31:0] iTypeImmd_TB;
    logic [31:0] sTypeImmd_TB;
    logic [31:0] jTypeImmd_TB;
    logic [31:0] bTypeImmd_TB;

    // Testing Logic 
    logic pass = 1; // 1 = pass, 0 = fail
    string testType; // u, i, s, j, b

    // Testing Array
    const int testArraySize = 20;
    logic [31:0] testArray [0:19];



    // Instantiate the Unit Under Test (UUT)
    ImmdGen uut (
        .instruction(instruction_TB), 
        .uTypeImmd(uTypeImmd_TB), 
        .iTypeImmd(iTypeImmd_TB), 
        .sTypeImmd(sTypeImmd_TB), 
        .jTypeImmd(jTypeImmd_TB), 
        .bTypeImmd(bTypeImmd_TB)
    );
    
    initial begin
        $readmemb("ImmdGenVerification.mem", testArray);
        for (int i = 0; i < testArraySize; i++) begin
            case(i)
               0: begin
                    $display ("\nU Type Immediate\n");
                    testType = "u";
                end
                4: begin
                    $display ("\nI Type Immediate\n");
                    testType = "i";
                end
                8: begin
                    $display ("\nS Type Immediate\n");
                    testType = "s";
                end
                12: begin
                    $display ("\nJ Type Immediate\n");
                    testType = "j";
                end
                16: begin
                    $display ("\nB Type Immediate\n");
                    testType = "b";
                end
               default;
            endcase
            
            // Display values for debugging and verification
            $display ("Instruction: %b", testArray[i]);
            instruction_TB = testArray[i];
            #10;
            case (testType)
                "u": $display ("uTypeImmd: %b", uTypeImmd_TB);
                "i": $display ("iTypeImmd: %b", iTypeImmd_TB);
                "s": $display ("sTypeImmd: %b", sTypeImmd_TB);
                "j": $display ("jTypeImmd: %b", jTypeImmd_TB);
                "b": $display ("bTypeImmd: %b", bTypeImmd_TB);
            endcase
        end
        $finish;
    end
endmodule
