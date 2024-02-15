`ifndef VERILATOR
module testbench;
  reg [4095:0] vcdfile;
  reg clock;
`else
module testbench(input clock, output reg genclock);
  initial genclock = 1;
`endif
  reg genclock = 1;
  reg [31:0] cycle = 0;
  reg [31:0] PI_sourceReg2;
  reg [31:0] PI_sourceReg1;
  BranchConditionGenFormal UUT (
    .sourceReg2(PI_sourceReg2),
    .sourceReg1(PI_sourceReg1)
  );
`ifndef VERILATOR
  initial begin
    if ($value$plusargs("vcd=%s", vcdfile)) begin
      $dumpfile(vcdfile);
      $dumpvars(0, testbench);
    end
    #5 clock = 0;
    while (genclock) begin
      #5 clock = 0;
      #5 clock = 1;
    end
  end
`endif
  initial begin
`ifndef VERILATOR
    #1;
`endif

    // state 0
    PI_sourceReg2 = 32'b01011000111001111100000111101111;
    PI_sourceReg1 = 32'b00100111000010000011111000010000;
  end
  always @(posedge clock) begin
    genclock <= cycle < 0;
    cycle <= cycle + 1;
  end
endmodule
