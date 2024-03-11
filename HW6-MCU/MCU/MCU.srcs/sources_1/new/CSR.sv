`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg 
// 
// Create Date: 03/08/2024 09:47:35 PM
// Module Name: CSR
// Project Name: OTTER
// Target Devices: Basys3
// Description: This is the register that will store the values that will be
//              needed when the OTTER enters an interrupt state.
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module CSR(
    // Inputs
    input CLK,
    input RESET,
    input MRET_EXEC,
    input INT_TAKEN,
    input [11:0] ADDR,
    input CSR_WE,
    input [31:0] PC,
    input [31:0] WD,

    // Outputs
    output logic MSTATUS,
    output logic [31:0] MEPC,
    output logic [31:0] MTVEC,
    output logic [31:0] RD
    );

    logic [31:0] mstatus;
    assign MSTATUS = mstatus[3];

    always_comb begin
        case (ADDR)
            12'h300: RD = mstatus;
            12'h305: RD = MTVEC;
            12'h341: RD = MEPC;
            default: RD = 32'hffffffff;
        endcase
    end
    
    always_ff @( posedge CLK ) begin 
        if (RESET) begin
            mstatus <= 32'h0;
            MEPC <= 32'h0;
            MTVEC <= 32'h0;
        end 
        else if (MRET_EXEC) begin
            mstatus[3] <= mstatus[7];
            mstatus[7] <= 1'b0;
        end
        else if (CSR_WE) begin
            if(ADDR == 12'h341)begin
                MEPC <= PC;
            end
            else if(ADDR == 12'h305)begin
                MTVEC <= WD;
            end
            else if(ADDR == 12'h300)begin
                mstatus <= WD;
            end
        end
        else if (INT_TAKEN) begin
            mstatus[7] <= mstatus[3];
            mstatus[3] <= 1'b0;
            MEPC <= PC;
        end
    end
    
endmodule
