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
    output logic memRDEN2,                  // Memory Read Enable 2
    output logic reset,                     // Reset
    output logic csr_WE,                    // Control and Status Register Write Enable
    output logic int_taken,                 // Interrupt
    output logic mret_exec                  // MRET Execution
);
    // Define the state type
    typedef enum { ST_INIT, ST_FETCH, ST_EXEC, ST_WB, ST_INTR} state_type;

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
        memRDEN2 = 1'b0;
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
                if(INTR)begin
                    next_state <= ST_INTR;
                end
                else begin
                    next_state <= ST_FETCH;
                end 
                case (opcode)
                // J-Type Instruction
                7'b1101111: begin
                    PC_WE = 1'b1;
                    RF_WE = 1'b1;
                    next_state = ST_FETCH;
                end
                // R-Type Instruction
                7'b0110011: begin
                    PC_WE = 1'b1;
                    RF_WE = 1'b1;
                    next_state = ST_FETCH;
                end
                // I-Type Instruction
                7'b0010011: begin
                    PC_WE = 1'b1;
                    memRDEN1 = 1'b1;
                    RF_WE = 1'b1;
                    next_state = ST_FETCH;
                end
                // JALR Instruction
                7'b1100111: begin
                    PC_WE = 1'b1;
                    memRDEN1 = 1'b1;
                    RF_WE = 1'b1;
                    next_state = ST_FETCH;
                end
                // Loading Instructions
                7'b0000011: begin
                    PC_WE = 1;
                    memRDEN1 = 1'b1;
                    memRDEN2 = 1;
                    RF_WE = 1'b1;
                    next_state = ST_WB;
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
                    memRDEN1 = 1'b1;
                    next_state = ST_FETCH;
                end
                // AUIPC Instruction
                7'b0010111: begin
                    PC_WE = 1'b1;
                    RF_WE = 1'b1;
                    memRDEN1 = 1'b1;
                    next_state = ST_FETCH;
                end
                // S-Type Instructions
                7'b0100011: begin
                    PC_WE = 1'b1;
                    memRDEN1 = 1'b1;
                    memWE2 = 1;
                    next_state = ST_FETCH;
                end
                // Interrupt Logic
                7'b1110011: begin
                    PC_WE = 1'b1;
                    case (funct3)
                        3'b011: begin
                            RF_WE = 1;
                            csr_WE = 1;
                        end
                        3'b010: begin
                            RF_WE = 1;
                            csr_WE = 1;
                        end
                        3'b001: begin
                            RF_WE = 1;
                            csr_WE = 1;
                        end
                        3'b000: begin
                            mret_exec = 1;
                        end
                        default: csr_WE = 0;
                    endcase
                end 

                default: next_state = ST_INIT; // Should never happen
                endcase
            end
            ST_WB: begin
                RF_WE = 1'b1;
                PC_WE = 0;
                if(INTR) begin
                    next_state <= ST_INTR;
                end
                else begin
                    next_state <= ST_FETCH;
                end
            end
            ST_INTR: begin
                PC_WE = 1;
                int_taken = 1;
                next_state = ST_FETCH;
            end
            default: next_state = ST_INIT; // Should never happen
        endcase
    end 
endmodule