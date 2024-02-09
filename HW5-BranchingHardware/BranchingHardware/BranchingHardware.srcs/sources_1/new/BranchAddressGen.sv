`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO 
// Engineer: Ethan Vosburg
// 
// Create Date: 02/07/2024 05:56:05 PM
// Module Name: BranchConditionGen
// Project Name: Branching Hardware
// Target Devices: Basys 3
// Description: This module will compare two 32-bit signed and unsigned numbers
// and then output the result of the comparison to three different outputs
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module BranchConditionGen(
    // Inputs
    input [31:0] programCounter,
    input [31:0] jTypeImmd,
    input [31:0] bTypeImmd,
    input [31:0] iTypeImmd,
    input [31:0] sourceReg1,

    // Outputs
    output logic [31:0] jal,
    output logic [31:0] branch,
    output logic [31:0] jalr
);

    // Generate the jal address
    assign jal = jTypeImmd + programCounter;

    // Generate the branch address
    assign branch = bTypeImmd + programCounter;
    
    // Generate the jalr address
    assign jalr = iTypeImmd + sourceReg1;

endmodule