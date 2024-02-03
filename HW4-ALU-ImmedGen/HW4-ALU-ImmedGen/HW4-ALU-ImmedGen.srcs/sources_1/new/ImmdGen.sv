`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO 
// Engineer: Ethan Vosburg
// 
// Create Date: 02/02/2024 11:47:05 AM
// Module Name: ImmdGen
// Project Name: Arithmetic Logic Unit and Immediate Generator
// Target Devices: Basys 3
// Description: This module is used to generate the immediate values for the Otter
// CPU.
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module ImmdGen(
    // Inputs
    input [31:0] instruction, // 32-bit instruction

    // Outputs
    output logic [31:0] uTypeImmd, 
    output logic [31:0] iTypeImmd,
    output logic [31:0] sTypeImmd,
    output logic [31:0] jTypeImmd,
    output logic [31:0] bTypeImmd
    );

    // U type immediate generation
    assign uTypeImmd = {instruction[31:12], 12'b0};
    
    // I type immediate generation
    assign iTypeImmd = {{20{instruction[31]}}, instruction[30:20]};
    
    // S type immediate generation
    assign sTypeImmd = {{20{instruction[31]}}, instruction[30:25], instruction[17:11]};

    // B type immediate generation
    assign jTypeImmd = {{11{instruction[31]}}, instruction[19:12], instruction[20], instruction[31:21], 1'b0};
    
    // J type immediate generation
    assign bTypeImmd = {{19{instruction[31]}}, instruction[7], instruction[30:25], instruction[18:11], 1'b0};
endmodule
