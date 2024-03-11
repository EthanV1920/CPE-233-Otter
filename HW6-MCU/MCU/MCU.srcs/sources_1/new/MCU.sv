`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ethan Vosburg 
// 
// Create Date: 02/21/2024 03:42:56 PM
// Module Name: MCU
// Project Name: Risc-V MCU
// Target Devices: Basys3
// Description: MCU linking all the submodules together
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module MCU(
    // Inputs
    input CLK,                          // Clock
    input RST,                          // Reset
    input INTR,                         // Interrupt
    input [31:0] IO_BUS_IN,             // IO Bus In

    // Outputs
    output [31:0] IOBUS_OUT,            // IO Bus Out
    output [31:0] IOBUS_ADDR,           // IO Bus Address
    output IOBUS_WR                     // IO Bus Write/Read Data
    );

    // Internal Wires
    logic [31:0] pc_mux, pc_count, pc_count_inc, alu_result, rs1, rs2, ir, ir2,
            rf_mux, utype, itype, stype, jtype, btype, csr_rd, jalr, branch,
            jal,alu_srca_mux, alu_srcb_mux, mtvec, mepc;
    logic pc_we, rf_we, memwe2, memrden1, memrden2, reset, csr_we, int_taken, 
            mret_exec, mstatus;
    logic [3:0] alu_fun;
    logic [1:0] alu_srca_mux_select, rf_mux_select;
    logic [2:0] alu_srcb_mux_select, pc_mux_select;

    // Submodules
    // Assign statments for single lines
    assign IOBUS_OUT = rs2;
    assign IOBUS_ADDR = alu_result;
    assign pc_count_inc = pc_count + 4;
    assign intr = INTR & mstatus;

    // Linking all modules together
    ProgramCounter PC(
        .PC_RST(RST),
        .PC_WE(pc_we),
        .PC_DIN(pc_mux),
        .CLK(CLK),
        .PC_COUNT(pc_count)
    );

    ProgramCounterMux PCM(
        .PC_COUNT_INCD(pc_count_inc),
        .JALR(jalr),
        .BRANCH(branch),
        .JAL(jal),
        .MTVEC(mtvec),
        .MEPC(mepc),
        .MUX_SELECT(pc_mux_select),
        .PC_MUX_OUT(pc_mux)
    );

    OtterMemory MEM(
        .MEM_CLK(CLK),
        .MEM_RDEN1(memrden1),
        .MEM_RDEN2(memrden2),
        .MEM_WE2(memwe2),
        .MEM_ADDR1(pc_count[15:2]),
        .MEM_ADDR2(alu_result),
        .MEM_DIN2(rs2),
        .MEM_SIZE(ir[13:12]),
        .MEM_SIGN(ir[14]),
        .IO_IN(IO_BUS_IN),
        .IO_WR(IOBUS_WR),
        .MEM_DOUT1(ir),
        .MEM_DOUT2(ir2)
        );

    RegFile RF(
        .CLK(CLK),
        .ADR1(ir[19:15]),
        .ADR2(ir[24:20]),
        .WADR(ir[11:7]),
        .ENABLE(rf_we),
        .WDATA(rf_mux),
        .RS1(rs1),
        .RS2(rs2)
    );

    ImmdGen IMM(
        .instruction(ir),
        .uTypeImmd(utype),
        .iTypeImmd(itype),
        .sTypeImmd(stype),
        .jTypeImmd(jtype),
        .bTypeImmd(btype)
    );

    BranchAddressGen BAG(
        .programCounter(pc_count),
        .jTypeImmd(jtype),
        .bTypeImmd(btype),
        .iTypeImmd(itype),
        .sourceReg1(rs1),
        .jal(jal),
        .branch(branch),
        .jalr(jalr)
    );

    ALU ALU(
        .srcA(alu_srca_mux),
        .srcB(alu_srcb_mux),
        .operation(alu_fun),
        .result(alu_result)
    );

    BranchConditionGen BCG(
        .sourceReg1(rs1),
        .sourceReg2(rs2),
        .equal(br_eq),
        .isLess(br_lt),
        .isLessUnsigned(br_ltu)
    );

    ControlUnitDecoder CUD(
        .br_eq(br_eq),
        .br_lt(br_lt),
        .br_ltu(br_ltu),
        .funct7(ir[31:25]),
        .opcode(ir[6:0]),
        .funct3(ir[14:12]),
        .ALU_FUN(alu_fun),
        .srcA_SEL(alu_srca_mux_select),
        .srcB_SEL(alu_srcb_mux_select),
        .PC_SEL(pc_mux_select),
        .RF_SEL(rf_mux_select)
    );

    ControlUnitFSM CUF(
        .CLK(CLK),
        .RST(RST),
        .INTR(intr),
        .opcode(ir[6:0]),
        .funct3(ir[14:12]),
        .PC_WE(pc_we),
        .RF_WE(rf_we),
        .memWE2(memwe2),
        .memRDEN1(memrden1),
        .memRDEN2(memrden2),
        .reset(reset),
        .csr_WE(csr_we),
        .int_taken(int_taken),
        .mret_exec(mret_exec)
    );
    
    RegFileMux RFM(
        .RF_SEL(rf_mux_select),
        .PC_COUNT_INC(pc_count_inc),
        .csr_RD(csr_rd),
        .MemoryDOUT2(ir2),
        .ALU_RESULT(alu_result),
        .muxOut(rf_mux)
    );

    ALUsrcAMux ALUsrcAM(
        .srcA_SEL(alu_srca_mux_select),
        .RS1(rs1),
        .uTypeImmd(utype),
        .notRS1(~rs1),
        .muxOut(alu_srca_mux)
    );

    ALUsrcBMux ALUsrcBM(
        .srcB_SEL(alu_srcb_mux_select),
        .RS2(rs2),
        .iTypeImmd(itype),
        .sTypeImmd(stype),
        .PC_COUNT(pc_count),
        .csr_RD(csr_rd),
        .muxOut(alu_srcb_mux)
    );
    
    CSR CSR(
        .CLK(CLK),
        .RESET(RST),
        .MRET_EXEC(mret_exec),
        .INT_TAKEN(int_taken),
        .ADDR(ir[31:20]),
        .CSR_WE(csr_we),
        .PC(pc_count),
        .WD(alu_result),
        .MSTATUS(mstatus),
        .MEPC(mepc),
        .MTVEC(mtvec),
        .RD(csr_rd)
    );
    
endmodule
