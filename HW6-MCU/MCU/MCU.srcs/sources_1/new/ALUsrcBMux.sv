`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg 
// 
// Create Date: 02/21/2024 06:53:42 PM
// Module Name: ALUsrcBMux
// Project Name: Otter MCU
// Target Devices: Basys3
// Description: ALU Source B Mux
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module ALUsrcBMux(
    // Inputs
    input [2:0] srcB_SEL,                   // Source B Select
    input [31:0] RS2,                       // Register Source 2
    input [31:0] iTypeImmd,                 // I-Type Immediate
    input [31:0] sTypeImmd,                 // S-Type Immediate
    input [31:0] PC_COUNT,                  // Program Counter Count
    input [31:0] csr_RD,                    // Control and Status Register Read

    // Outputs
    output logic [31:0] muxOut              // Mux Output
    );

    always_comb begin
        case (srcB_SEL)
            0: muxOut = RS2;
            1: muxOut = iTypeImmd;
            2: muxOut = sTypeImmd;
            3: muxOut = PC_COUNT;
            4: muxOut = csr_RD;
            default: muxOut = 32'h0;
        endcase
    end

endmodule
