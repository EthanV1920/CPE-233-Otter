`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg
// 
// Create Date: 01/19/2024 03:52:57 PM
// Module Name: ProgramCounter
// Project Name: Program Counter
// Target Devices: Basys3
// Description: Take in a 32 bit value and store it in a register while
//              incrementing it by 4.
//
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module ProgramCounter(
    // Inputs
    input PC_RST,                       // Reset
    input PC_WE,                        // Write Enable
    input [31:0] PC_DIN,                // Data In
    input CLK,                          // Clock

    // Outputs
    output logic [31:0] PC_COUNT,       // Data Out
    output logic [31:0] PC_COUNT_INC    // Data Out Incremented by 4
    );


    // #TODO: change to comb
    PC_COUNT_INC <= PC_DIN + 4; // Write the Data In to the Program Counter and increment by 4

    always_ff @( posedge CLK ) begin
        if (PC_RST) begin
            PC_COUNT <= 32'h0000_0000;  // Reset the Program Counter to 0
        end else if (PC_WE) begin
            // this should be combinational assign
            PC_COUNT <= PC_DIN; // Write the signal #TODO: Make this better
        end
    end
    
endmodule