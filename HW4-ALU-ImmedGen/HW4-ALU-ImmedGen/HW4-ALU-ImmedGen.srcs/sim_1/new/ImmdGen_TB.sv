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
    logic [31:7] instruction_TB; // 32-bit instruction

    // Outputs
    logic [31:0] uTypeImmd_TB;
    logic [31:0] iTypeImmd_TB;
    logic [31:0] sTypeImmd_TB;
    logic [31:0] jTypeImmd_TB;
    logic [31:0] bTypeImmd_TB;


    // Instantiate the Unit Under Test (UUT)
    ImmdGen uut (
        .instruction(instruction_TB), 
        .uTypeImmd(uTypeImmd_TB), 
        .iTypeImmd(iTypeImmd_TB), 
        .sTypeImmd(sTypeImmd_TB), 
        .jTypeImmd(jTypeImmd_TB), 
        .bTypeImmd(bTypeImmd_TB)
    );
endmodule
