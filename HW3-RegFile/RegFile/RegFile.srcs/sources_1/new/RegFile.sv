`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg
// 
// Create Date: 01/26/2024 06:24:51 PM
// Module Name: RegFile
// Project Name: RegFile
// Target Devices: Basys 3
// Description: Create a Register for the ALU
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module RegFile(
    // Inputs
    input ENABLE,
    input CLK,
    input [4:0] ADR1,
    input [4:0] ADR2,
    input [4:0] WADR,
    input [31:0] WDATA,

    // Outputs
    output logic [31:0] RS1,
    output logic [31:0] RS2
    );

    // Declare register array
    logic [31:0] register [0:31];

    always_ff @( posedge CLK ) begin
        if (ENABLE == 1) begin
            // Write data to register
            register[WADR] <= WDATA;
        end

        // Present data from 2 desire 
        RS1 <= register[ADR1];
        RS2 <= register[ADR2];
        
        // Add logic for zero register
        if (ADR1 == 0) begin
            RS1 <= 32'h0000_0000;
        end
        if (ADR2 == 0) begin
            RS2 <= 32'h0000_0000;
        end
    end
endmodule
