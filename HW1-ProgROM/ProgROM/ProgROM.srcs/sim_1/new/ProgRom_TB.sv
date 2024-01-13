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
    logic PROG_CLK_TB; // 1-bit clock
    logic [31:0] PROG_ADDR_TB; // 32-bit address

    // Outputs
    logic [31:0] INSTRUCT_TB; // 32-bit machine code instruction

    // Logic
    logic pass; // 1 = pass, 0 = fail

    // rom_TB type set up
    (* rom_style="{distributed | block}" *)
	(* ram_decomp = "power" *) logic [31:0] rom_TB [0:16383];

    // Instantiate the Unit Under Test (UUT)
    ProgRom uut (
        .PROG_CLK(PROG_CLK_TB), 
        .PROG_ADDR(PROG_ADDR_TB), 
        .INSTRUCT(INSTRUCT_TB)
    );

    // Begin simulation code
    initial begin
        // Initialize Logic
        PROG_CLK_TB = 0; // Initialize PROG_CLK_TB
        pass = 1; // Initialize pass to 1
        
        $readmemh("otter_memory.mem", rom_TB , 0, 16383); // Read in otter_memory.mem file

        // Iterate through rom_TB and compare to INSTRUCT_TB
        // If there is a mismatch, set pass to 0
        // Note: the comparison is hardcoded to stop for this case
        for (int i = 0; i < 7; i++) begin
            PROG_ADDR_TB = 32'h0000_0000 + (i*4); // Request machine code instruction from address
            #20 // Wait for INSTRUCT_TB to be updated

            // Display values for debugging and verification
            $display("rom[%0d]: %h", i, INSTRUCT_TB);
            $display("rom_tb[%0d]: %h", i, rom_TB[i]);

            // Compare INSTRUCT_TB to rom_TB[i]
            if (INSTRUCT_TB == (32'h0000_0000 + rom_TB[i])) begin
                $display("Match rom_TB[%0d] = %h", i, rom_TB[i]);
            end else begin
                $display("No Match rom_TB[%0d] = %h", i, rom_TB[i]);
                pass = 0; // Do not allow the test to pass
            end
            #20;
        end

        // Display overall pass/fail
        if (pass == 1) begin
            $display("OVERALL PASS");
        end else begin
            $display("OVERALL FAIL");
        end 
    end

    // Toggle the clock
    always #5 PROG_CLK_TB = ~PROG_CLK_TB;


endmodule