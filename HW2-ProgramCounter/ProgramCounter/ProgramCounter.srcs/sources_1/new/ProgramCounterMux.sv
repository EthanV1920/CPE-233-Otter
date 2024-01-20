`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg
// 
// Create Date: 01/19/2024 03:52:57 PM
// Module Name: ProgramCounterMux
// Project Name: Program Counter
// Target Devices: Basys3
// Description: Determine which signal to use to drive the program counter taking
//              in multiple signals and outputting one.
//
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

module ProgramCounterMux(
    // Inputs
    input [31:0] PC_COUNT_INCD,     // Program Counter Incremented by 4
    input [31:0] JALR,              // Jump and Link Register
    input [31:0] BRANCH,            // Branch jump
    input [31:0] JAL,               // Jump and Link
    input [31:0] MTVEC,             // Machine Trap Vector
    input [31:0] MEPC,              // Machine Exception Program Counter
    input [2:0] MUX_SELECT,        // Select which signal to output

    // Outputs
    output logic [31:0] PC_MUX_OUT
);

    // Begin Multiplexer Code Block
    always_comb begin
        case (MUX_SELECT)
            0: PC_MUX_OUT = PC_COUNT_INCD;
            1: PC_MUX_OUT = JALR;
            2: PC_MUX_OUT = BRANCH;
            3: PC_MUX_OUT = JAL;
            4: PC_MUX_OUT = MTVEC;
            5: PC_MUX_OUT = MEPC;
            6: PC_MUX_OUT = PC_COUNT_INCD;          // Default to PC_COUNT_INCD
            7: PC_MUX_OUT = PC_COUNT_INCD;          // Default to PC_COUNT_INCD
            default: PC_MUX_OUT = PC_COUNT_INCD;    // Default to PC_COUNT_INCD
        endcase
    end

endmodule