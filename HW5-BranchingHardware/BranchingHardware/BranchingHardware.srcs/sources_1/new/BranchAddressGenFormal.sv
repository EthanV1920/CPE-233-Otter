`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO 
// Engineer: Ethan Vosburg
// 
// Create Date: 02/9/2024 09:56:05 PM
// Module Name: BranchAddressGenFormal
// Project Name: Branching Hardware
// Target Devices: Basys 3
// Description: This module will formally verify that the branch address
// generator module will work correctly.
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


`include "BranchAddressGen.sv"

module BranchAddressGenFormal(
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


BranchAddressGen BranchAddressGen(
    .programCounter(programCounter),
    .jTypeImmd(jTypeImmd),
    .bTypeImmd(bTypeImmd),
    .iTypeImmd(iTypeImmd),
    .sourceReg1(sourceReg1),
    .jal(jal),
    .branch(branch),
    .jalr(jalr)
);


always @(*) begin
    // Check for the jal branch verification
    assert(jal == programCounter +jTypeImmd);

    // Check for the branch address verification
    assert(branch == programCounter + bTypeImmd);

    // Check for the jalr  verification
    assert(jalr == sourceReg1 + iTypeImmd);
end

endmodule