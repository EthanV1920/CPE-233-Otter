`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO 
// Engineer: Ethan Vosburg
// 
// Create Date: 02/9/2024 09:56:05 PM
// Module Name: BranchConditionGenFormal
// Project Name: Branching Hardware
// Target Devices: Basys 3
// Description: This module will formally verify that the branch condition 
// generator module will work correctly.
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


`include "BranchConditionGen.sv"

module BranchConditionGenFormal(
    // Inputs
    input [31:0] sourceReg1,
    input [31:0] sourceReg2,

    // Outputs
    output equal,
    output isLess,
    output isLessUnsigned 
);

BranchConditionGen BranchAddressGen(
    .sourceReg1(sourceReg1),
    .sourceReg2(sourceReg2),
    .equal(equal),
    .isLess(isLess),
    .isLessUnsigned(isLessUnsigned)
);

always @(*) begin
    // Check for equal condition
    if (sourceReg2 == sourceReg1) begin
        assert(equal == 1'b1);
    end

    // Check for less than 
    if ($signed(sourceReg1) < $signed(sourceReg2)) begin
        assert(isLess == 1'b1);
    end

    // Check for less than unsigned
    if (sourceReg1 < sourceReg2) begin
        assert(isLessUnsigned == 1'b1);
    end

    // Test if both isLessUnsigned and isLess can be reached at the same time
    cover(isLessUnsigned == 1'b1 && isLess ==1'b1);
end
endmodule