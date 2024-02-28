`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg
// 
// Create Date: 02/21/2024 06:53:42 PM
// Module Name: ALUsrcAMux
// Project Name: Otter MCu
// Target Devices: Basys3
// Description: ALU Source A Mux
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module ALUsrcAMux(
    // Inputs
    input [1:0] srcA_SEL,                   // Source A Select
    input [31:0] RS1,                       // Register Source 1
    input [31:0] uTypeImmd,                 // U-Type Immediate
    input [31:0] notRS1,                    // Not Register Source 1

    // Outputs
    output logic [31:0] muxOut              // Mux Output
    );

    always_comb begin
        case (srcA_SEL)
            0: muxOut = RS1;
            1: muxOut = uTypeImmd;
            2: muxOut = notRS1;
            default: muxOut = 32'h0;
        endcase
    end
    
endmodule
