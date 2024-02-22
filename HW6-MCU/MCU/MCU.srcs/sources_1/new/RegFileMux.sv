`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg
// 
// Create Date: 02/21/2024 06:53:42 PM
// Module Name: RegFileMux
// Project Name: Otter MCU
// Target Devices: Basys3
// Description: Register File Mux
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module RegFileMux(
    // Inputs
    input [1:0] RF_SEL,                     // Register File Select
    input [31:0] PC_COUNT_INC,              // Program Counter Count Increment
    input [31:0] csr_RD,                    // Control and Status Register Read
    input [31:0] MemoryDOUT2,               // Memory Data Out 2
    input [31:0] ALU_RESULT,                // ALU Result

    // Outputs
    output logic [31:0] muxOut              // Mux Output
    );

    always_comb begin
        case (RF_SEL)
            2'b00: muxOut = PC_COUNT_INC;
            2'b01: muxOut = csr_RD;
            2'b10: muxOut = MemoryDOUT2;
            2'b11: muxOut = ALU_RESULT;
            default: muxOut = 32'h0;
        endcase
    end
    
endmodule
