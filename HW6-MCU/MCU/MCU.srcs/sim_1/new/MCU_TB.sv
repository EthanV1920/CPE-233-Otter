`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg
// 
// Create Date: 02/21/2024 10:56:25 PM
// Module Name: MCU_TB
// Project Name: Otter MCU
// Target Devices: Basys3
// Description: Testbench for the Otter MCU
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module MCU_TB();
    // Inputs
    logic RST_TB = 1'b0; // Reset
    logic CLK_TB = 1'b0; // Clock
    logic INTR_TB = 1'b0; // Interrupt
    logic [31:0] IOBUS_IO_TB = 32'b001; // IO Bus

    // Outputs
    logic [31:0] IOBUS_IO_OUT_TB; // IO Bus Output
    logic [31:0] IOBUS_ADDR_TB; // IO Bus Address
    logic IOBUS_WR_TB; // IO Bus Write/Read Data

    // Instantiate the MCU
    MCU MCU_INST(
        .CLK(CLK_TB),
        .RST(RST_TB),
        .INTR(INTR_TB),
        .IO_BUS_IN(IOBUS_IO_TB),
        .IOBUS_OUT(IOBUS_IO_OUT_TB),
        .IOBUS_ADDR(IOBUS_ADDR_TB),
        .IOBUS_WR(IOBUS_WR_TB)
    ); 
    initial begin
        CLK_TB = 1'b0;
        RST_TB = 1'b1;
        #10 RST_TB = 1'b0;

        #1500;

        INTR_TB = 1;
        #40 INTR_TB = 0;


    end

    // Instantiate the clock
    always #5 CLK_TB = ~CLK_TB;

endmodule
