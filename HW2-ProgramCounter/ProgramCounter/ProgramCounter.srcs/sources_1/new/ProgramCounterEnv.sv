`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg
// 
// Create Date: 01/19/2024 03:52:57 PM
// Module Name: ProgramCounterEnv
// Project Name: Program Counter
// Target Devices: Basys3
// Description: Testing envoriment for the prorgram counter allowing for the
//              multiplexer and program counter to be tested together.
//
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

module ProgramCounterEnv(
    // Inputs
    input ENV_RST,                          // Reset
    input ENV_WE,                           // Write Enable
    input [31:0] ENV_JALR,                  // Jump and Link Register
    input [31:0] ENV_BRANCH,                // Branch jump
    input [31:0] ENV_JAL,                   // Jump and Link
    input [31:0] ENV_MTVEC,                 // Machine Trap Vector
    input [31:0] ENV_MEPC,                  // Machine Exception Program Counter
    input [2:0]  ENV_MUX_SELECT,            // Select which signal to output
    input ENV_CLK,                          // Clock

    // Outputs
    output logic [31:0] ENV_PC_COUNT,       // Data Out
    output logic [31:0] ENV_PC_COUNT_INC    // Data Out Incremented by 4
);
    // Logic
    logic [31:0] mux_pc;                    // Multiplexer connection to PC

    // Instantiate the Program Counter
    ProgramCounter PC(
        .PC_RST(ENV_RST),
        .PC_WE(ENV_WE),
        .PC_DIN(mux_pc),
        .CLK(ENV_CLK),
        .PC_COUNT(ENV_PC_COUNT),
        .PC_COUNT_INC(ENV_PC_COUNT_INC)
    );

    // Instantiate the Program Counter Multiplexer
    ProgramCounterMux PC_MUX(
        .PC_COUNT_INCD(ENV_PC_COUNT_INC),
        .JALR(ENV_JALR),
        .BRANCH(ENV_BRANCH),
        .JAL(ENV_JAL),
        .MTVEC(ENV_MTVEC),
        .MEPC(ENV_MEPC),
        .MUX_SELECT(ENV_MUX_SELECT),
        .PC_MUX_OUT(mux_pc)
    );

endmodule