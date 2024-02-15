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
  reg [31:0] PI_jTypeImmd;
  reg [31:0] PI_bTypeImmd;
  reg [31:0] PI_programCounter;
  reg [31:0] PI_iTypeImmd;
  reg [31:0] PI_sourceReg1;
  BranchAddressGenFormalBug UUT (
    .jTypeImmd(PI_jTypeImmd),
    .bTypeImmd(PI_bTypeImmd),
    .programCounter(PI_programCounter),
    .iTypeImmd(PI_iTypeImmd),
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
    PI_jTypeImmd = 32'b00000000000000000000000000000000;
    PI_bTypeImmd = 32'b00000000000000000000000000000000;
    PI_programCounter = 32'b00000000000000000000000000000000;
    PI_iTypeImmd = 32'b00000000000000000000000000000000;
    PI_sourceReg1 = 32'b00000000000000000000000000000000;
  end
  always @(posedge clock) begin
    genclock <= cycle < 0;
    cycle <= cycle + 1;
  end
endmodule
