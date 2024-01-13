`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg
// 
// Create Date: 01/11/2024 10:40:40 PM
// Design Name: 
// Module Name: ProgRom_TB
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


module ProgRom_TB();
    // Inputs
    logic PROG_CLK_TB;
    logic [31:0] PROG_ADDR_TB;

    // Outputs
    logic [31:0] INSTRUCT_TB;

    // Logic
    // (* rom_style="{distributed | block}" *)
	// // (* ram_decomp = "power" *) logic [31:0] rom_TB [0:16383];
	// (* ram_decomp = "power" *) logic [31:0] rom_TB [0:6];

    logic [31:0] rom_TB [$];
    logic pass;

    // Instantiate the Unit Under Test (UUT)
    ProgRom uut (
        .PROG_CLK(PROG_CLK_TB), 
        .PROG_ADDR(PROG_ADDR_TB), 
        .INSTRUCT(INSTRUCT_TB)
    );

    initial begin
        PROG_CLK_TB = 0;
        $readmemh("otter_memory.mem", rom_TB);
        pass = 1;
        for (int i = 0; i < rom_TB.size(); i++) begin
        // for (int i = 0; i < 6; i++) begin
            PROG_ADDR_TB = 32'h0000_0000 + (i*4);
            #20;
            $display("rom[%0d]: %h", i, INSTRUCT_TB);
            $display("rom_tb[%0d]: %h", i, rom_TB[i]);

            if (INSTRUCT_TB == (32'h0000_0000 + rom_TB[i])) begin
                $display("Match rom_TB[%0d] = %h", i, rom_TB[i]);
            end else begin
                $display("No Match rom_TB[%0d] = %h", i, rom_TB[i]);
                pass = 0;
            end
            #20;
        end

        if (pass == 1) begin
            $display("OVERALL PASS");
        end else begin
            $display("OVERALL FAIL");
        end 
    end

    always #5 PROG_CLK_TB = ~PROG_CLK_TB;


endmodule