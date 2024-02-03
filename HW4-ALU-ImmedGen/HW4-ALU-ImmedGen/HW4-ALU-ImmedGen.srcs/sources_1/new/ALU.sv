`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal POly SLO 
// Engineer: Ethan Vosburg
// 
// Create Date: 02/02/2024 11:47:05 AM
// Module Name: ImmdGen
// Project Name: Arithmetic Logic Unit
// Target Devices: Basys 3
// Description: This module is used to perform arithmetic on two inputs
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU(
    // Inputs
    input [31:0] srcA,          // 32-bit input A
    input [31:0] srcB,          // 32-bit input B
    input [3:0] operation,      // 5-bit function code

    // Outputs
    output logic [31:0] result  // 32-bit result
    );

always_comb begin
    case (operation)
        4'b0000: result = srcA + srcB;                      // ADD: Add
        4'b0001: result = srcA - srcB;                      // SUB: Subtract
        4'b0110: result = srcA | srcB;                      // OR: or the two inputs
        4'b0111: result = srcA & srcB;                      // AND: and the two inputs
        4'b0100: result = srcA ^ srcB;                      // XOR: xor the two inputs
        4'b0101: result = srcA << srcB;                     // SRL: logical shift left
        4'b1000: result = srcA >> srcB;                     // SLL: logical shift right
        4'b1101: result = srcA >>> srcB;                    // SRA: shift right arithmetic
        4'b0010: result = srcA > srcB;                      // SLT: set less than
        4'b0011: result = $signed(srcA) >= $signed(srcB);   // SLTU: set less than or equal #TODO: check this
        4'b1001: result = srcA;                             // LUI-COPY: copy srcA to result
        default: result = result;                           // default case 
    endcase
end

endmodule