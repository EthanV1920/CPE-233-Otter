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
    input br_eq,                            // Branch Equal
    input br_lt,                            // Branch Less Than
    input br_ltu,                           // Branch Less Than Unsigned
    input [6:0] funct7,                     // Function 7
    input [6:0] opcode,                     // Opcode
    input [2:0] funct3,                     // Function 3
    input int_taken,                        // Interrupt taken flag

    // Outputs
    output logic [3:0] ALU_FUN,             // ALU Function
    output logic [1:0] srcA_SEL,            // Source A Select
    output logic [2:0] srcB_SEL,            // Source B Select
    output logic [2:0] PC_SEL,              // Program Counter Select
    output logic [1:0] RF_SEL               // Register File Select
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
            srcB_SEL = 0;
            PC_SEL = 3'b0;
            RF_SEL = 2'b11;
            // Logic for ALU Select B
            // if ({funct7[5], funct3} == 4'b0010) srcB_SEL = 3'b1;
            // if ({funct7[5], funct3} == 4'b0100) srcB_SEL = 3'b0;
        end
        // I-Type Instruction
        7'b0010011: begin
            // Take care of special case with SRAI
            if (funct3 == 3'b101)
                ALU_FUN = {funct7[5], funct3};
            else
                ALU_FUN = {1'b0, funct3};
            
            // Configure selects
            srcA_SEL = 2'b0;
            srcB_SEL = 3'b1;
            RF_SEL = 2'b11;
            PC_SEL = 3'b0;
        end
        // JALR Instructions
        7'b1100111: begin
            PC_SEL = 3'b1;
            // ALU_FUN = {1'b0, funct3};
            // srcA_SEL = 2'b0;
            // srcB_SEL = 3'b1;
            RF_SEL = 2'b0;
        end
        // Loading Instructions
        7'b0000011: begin
            PC_SEL = 3'b0;
            RF_SEL = 2;
            srcA_SEL = 0;
            srcB_SEL = 1;
            ALU_FUN = 4'b0000;
        end 
        // J-Type Instruction
        7'b1101111: begin
            PC_SEL = 3'b11;
            RF_SEL = 2'b0;
        end
        // B-Type Instruction
        7'b1100011: begin
            case(funct3)
                3'b000: begin
                    if (br_eq)
                        PC_SEL = 3'b10;
                    else
                        PC_SEL = 3'b0;
                end

                3'b101: begin
                    if (!br_lt) 
                        PC_SEL = 3'b10;
                    else
                        PC_SEL = 3'b0;
                end

                3'b111: begin
                    if (!br_ltu)
                        PC_SEL = 3'b10;
                    else
                        PC_SEL = 3'b0;
                end

                3'b100: begin
                    if (br_lt)
                        PC_SEL = 3'b10;
                    else
                        PC_SEL = 3'b0;
                end

                3'b110: begin
                    if (br_ltu)
                        PC_SEL = 3'b10;
                    else
                        PC_SEL = 3'b0;
                end

                3'b001: begin
                    if (!br_eq) 
                        PC_SEL = 3'b10;
                    else
                        PC_SEL = 3'b0;
                end

                default: PC_SEL = 3'b111;
            endcase
        end
        // U-Type Instruction
        7'b0110111: begin
            ALU_FUN = 4'b1001;
            srcA_SEL = 2'b1;
            PC_SEL = 3'b0;
            RF_SEL = 2'b11;
        end

        // AUIPC Command
        7'b0010111: begin
            ALU_FUN = 4'b0000;
            srcA_SEL = 2'b1;
            srcB_SEL = 3'b11;
            PC_SEL = 3'b0;
            RF_SEL = 2'b11;
        end
        // S-Type Instruction
        7'b0100011: begin
            ALU_FUN = 0;
            srcA_SEL = 0;
            srcB_SEL = 2;
            PC_SEL = 0;
        end
        // Interrupt functions
        7'b1110011: begin
            case(funct3)
                // CSRRW
                3'b001: begin
                    ALU_FUN = 4'b1001;
                    RF_SEL = 2'b01; 
                end
                3'b010: begin
                    ALU_FUN = 4'b0110;
                    srcB_SEL = 3'b100;
                    RF_SEL = 2'b01; 
                end
                3'b011:begin
                    ALU_FUN = 4'b0111;
                    srcA_SEL = 2'b10;
                    srcB_SEL = 3'b100;
                    RF_SEL = 2'b01; 
                end

            endcase


        end

        default: begin
            // Should not be used
            ALU_FUN = 4'b0000;
            srcA_SEL = 2'b1;
            srcB_SEL = 3'b11;
            PC_SEL = 3'b0;
            RF_SEL = 2'b11;
        end
        endcase
        
        if(int_taken)begin
            PC_SEL = 3'b100;
        end
        
    end


endmodule
