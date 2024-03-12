`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2024 11:25:32 PM
// Design Name: 
// Module Name: CSR_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CSR_TB();
    // Inputs
    logic CLK_TB = 1;
    logic RESET_TB;
    logic MRET_EXEC_TB;
    logic INT_TAKEN_TB;
    logic [11:0] ADDR_TB;
    logic CSR_WE_TB;
    logic [31:0] PC_TB;
    logic [31:0] WD_TB;

    // Outputs
    logic MSTATUS_TB;
    logic [31:0] MEPC_TB;
    logic [31:0] MTVEC_TB;
    logic [31:0] RD_TB;

    // Instantiate Clock
    always #5 CLK_TB = ~CLK_TB;

    CSR CRSTB(
        .CLK(CLK_TB),
        .RESET(RESET_TB),
        .MRET_EXEC(MRET_EXEC_TB),
        .INT_TAKEN(INT_TAKEN_TB),
        .ADDR(ADDR_TB),
        .CSR_WE(CSR_WE_TB),
        .PC(PC_TB),
        .WD(WD_TB),
        .MSTATUS(MSTATUS_TB),
        .MEPC(MEPC_TB),
        .MTVEC(MTVEC_TB),
        .RD(RD_TB)
    );
    
    initial begin
        RESET_TB = 1;
        #10;
        RESET_TB = 0;

        

    end
endmodule
