`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg 
// 
// Create Date: 02/21/2024 03:42:56 PM
// Module Name: ControlUnitFSM 
// Project Name: Risc-V MCU
// Target Devices: Basys3
// Description: Control Unit FSM for the Risc-V MCU 
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module ControlUnitFSM(
    // Inputs
    input CLK,                              // Clock
    input RST,                              // Reset
    input INTR,                             // Interrupt
    input [6:0] opcode,                     // Opcode
    input [2:0] funct3,                     // Function 3

    // Outputs
    output logic PC_WE,                     // Program Counter Write Enable
    output logic RF_WE,                     // Register File Write Enable
    output logic memWE2,                    // Memory Write Enable 2
    output logic memRDEN1,                  // Memory Read Enable 1
    output logic memeRDEN2,                 // Memory Read Enable 2
    output logic reset,                     // Reset
    output logic csr_WE,                    // Control and Status Register Write Enable
    output logic int_taken,                 // Interrupt
    output logic mret_exec                  // MRET Execution
);
    // Define the state type
    typedef enum { ST_INIT, ST_FETCH, ST_EXEC } state_type;

    //  Define state and next state
    state_type state, next_state;

    // Transition State
    always_ff @(posedge CLK) begin
        if (RST) begin
            state <= ST_INIT;
        end else begin
            state <= next_state;
        end
    end


    // Define the state logic
    always_comb begin
        // Initialize all the outputs to zeros
        PC_WE = 1'b0;
        RF_WE = 1'b0;
        memWE2 = 1'b0;
        memRDEN1 = 1'b0;
        memeRDEN2 = 1'b0;
        reset = 1'b0;
        csr_WE = 1'b0;
        int_taken = 1'b0;
        mret_exec = 1'b0;

        case (state)
            ST_INIT: begin
                reset = 1'b1;
                next_state = ST_FETCH;
            end 
            ST_FETCH: begin
                memRDEN1 = 1'b1;
                next_state = ST_EXEC;
            end
            ST_EXEC: begin
                case (opcode)
                // R-Type Instruction
                7'b0110011: begin
                    PC_WE = 1'b1;
                    RF_WE = 1'b1;
                    next_state = ST_FETCH;
                end
                // I-Type Instruction
                7'b0010011: begin
                    PC_WE = 1'b1;
                    RF_WE = 1'b1;
                    next_state = ST_FETCH;
                end
                // B-Type Instruction
                7'b1100011: begin
                    PC_WE = 1'b1;
                    next_state = ST_FETCH;
                end
                // U-Type Instruction
                7'b0110111: begin
                    PC_WE = 1'b1;
                    RF_WE = 1'b1;
                    next_state = ST_FETCH;
                end

                default: next_state = ST_INIT; // Should never happen
                endcase
            end
            default: next_state = ST_INIT; // Should never happen
        endcase
    end 
endmodule