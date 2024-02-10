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
    input [31:0] sourceReg1,
    input [31:0] sourceReg2,

    // Outputs
    output equal,
    output isLess,
    output isLessUnsigned 
    );

    // Flag equal out as high if reg1 is equal to reg2
    assign equal = (sourceReg1 == sourceReg2) ? 1'b1 : 1'b0;

    // Flag isLess is comparison is valid 
    // Note: Numbers are interpreted as unsigned by default
    assign isLess = ($signed(sourceReg1) < $signed(sourceReg2)) ? 1'b1 : 1'b0;
    
    // Flag isLessUnsigned if comparison is true
    assign isLessUnsigned = (sourceReg1 < sourceReg2) ? 1'b1 : 1'b0;
endmodule