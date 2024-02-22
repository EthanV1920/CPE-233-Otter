`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg
// 
// Create Date: 02/21/2024 03:47:15 PM
// Module Name: ControlUnitDecoder
// Project Name: Otter MCU
// Target Devices: Basys3
// Description: Control Unit Decoder for controlling the ALU
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module ControlUnitDecoder(
    // Inputs
    input br_eq,                         // Branch Equal
    input br_lt,                         // Branch Less Than
    input br_ltu,                        // Branch Less Than Unsigned
    input [6:0] funct7,                  // Function 7
    input [6:0] opcode,                  // Opcode
    input [2:0] funct3,                  // Function 3

    // Outputs
    output logic [3:0] ALU_FUN,                // ALU Function
    output logic [1:0] srcA_SEL,               // Source A Select
    output logic [2:0] srcB_SEL,               // Source B Select
    output logic [2:0] PC_SEL,                 // Program Counter Select
    output logic [1:0] RF_SEL                  // Register File Select
    );

    always_comb begin
        // Initialize all the outputs to zeros
        ALU_FUN = 4'b0000;
        srcA_SEL = 2'b0;
        srcB_SEL = 3'b0;
        PC_SEL = 3'b0;
        RF_SEL = 2'b00;
        
        case (opcode)
        // R-Type Instruction
        7'b0110011: begin
            ALU_FUN = {funct7[5], funct3};
            srcA_SEL = 2'b0;
            srcB_SEL = 3'b0;
            PC_SEL = 3'b0;
            RF_SEL = 2'b11;
        end
        // I-Type Instruction
        7'b0010011: begin
            ALU_FUN = {1'b0, funct3};
            srcA_SEL = 2'b0;
            srcB_SEL = 3'b1;
            PC_SEL = 3'b0;

        end
        // B-Type Instruction
        7'b1100011: begin
            PC_SEL = 3'b10;
        end
        // U-Type Instruction
        7'b0110111: begin
            ALU_FUN = 4'b1001;
            srcA_SEL = 2'b0;
            PC_SEL = 3'b0;
            RF_SEL = 2'b11;
        end

        default:begin
            // Should never happen
            ALU_FUN = 4'b0000;
            srcA_SEL = 2'b0;
            srcB_SEL = 3'b0;
            PC_SEL = 3'b0;
            RF_SEL = 2'b00;
        end
        endcase
        
    end


endmodule
