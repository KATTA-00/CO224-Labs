// CO224 - Lab05 PART-3
// GROUP - 11

// include modules
`include "alu.v"
`include "reg_file.v"
`include "pc.v"
`include "control_unit.v"
`include "modules.v"


module cpu(PC, INSTRUCTION, CLK, RESET);

    input CLK, RESET;
    input [31:0] INSTRUCTION;

    output [31:0] PC;

    wire ZERO;
    wire [31:0] PC_NEXT, PC_TARGET, PC_4;
    wire [2:0] ALUOP;
    wire WRITEENABLE, COMPSELECT, IMMEDIATESELECT, JUMP, BRANCH, PCSELECT;
    wire [7:0] ALURESULT, REGOUT2, REGOUT1, COMPOUT, MUX1, ALUIN;


    pc Pc(PC_NEXT, RESET, CLK, PC, PC_4);
    control_unit Control_Unit(INSTRUCTION[31:24], WRITEENABLE, COMPSELECT, IMMEDIATESELECT,JUMP, BRANCH, ALUOP);
    reg_file Reg_File(ALURESULT, REGOUT1, REGOUT2, INSTRUCTION[18:16], INSTRUCTION[10:8], INSTRUCTION[2:0], WRITEENABLE, CLK,RESET);
    two_comp Two_Com(REGOUT2, COMPOUT);

    pc_adder Pc_Adder(PC_4, INSTRUCTION[23:16], PC_TARGET);

    mux_8 Mux1(REGOUT2, COMPOUT, COMPSELECT, MUX1);
    mux_8 Mux2(MUX1, INSTRUCTION[7:0], IMMEDIATESELECT, ALUIN);
    
    alu Alu(REGOUT1, ALUIN, ALURESULT, ALUOP, ZERO);

    wire wire1;
    and(wire1, BRANCH, ZERO);
    or(PCSELECT, JUMP, wire1);

    mux_32 Mux3(PC_4, PC_TARGET, PCSELECT, PC_NEXT);


    // always @(INSTRUCTION, ALUIN, IMMEDIATESELECT)
    // $display($time, " %d %d %d", INSTRUCTION[7:0], ALUIN, IMMEDIATESELECT);

endmodule
