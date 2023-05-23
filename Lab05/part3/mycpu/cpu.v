// CO224 - Lab05 PART-3
// GROUP - 11

// include modules
`include "alu.v"
`include "reg_file.v"
`include "pc.v"
`include "control_unit.v"
`include "modules.v"

//cpu module
module cpu(PC, INSTRUCTION, CLK, RESET);

    input CLK, RESET;
    input [31:0] INSTRUCTION; // instruction array

    output [31:0] PC; // address of the current executing instruction

    wire [2:0] ALUOP; //select bit of ALU
    wire WRITEENABLE, COMPSELECT, IMMEDIATESELECT; // control signals
    wire [7:0] ALURESULT, REGOUT2, REGOUT1, COMPOUT, MUX1, ALUIN; // 

    //initialization of sub modules
    pc Pc(RESET, CLK, PC);
    control_unit Control_Unit(INSTRUCTION[31:24], WRITEENABLE, COMPSELECT, IMMEDIATESELECT, ALUOP);
    reg_file Reg_File(ALURESULT, REGOUT1, REGOUT2, INSTRUCTION[18:16], INSTRUCTION[10:8], INSTRUCTION[2:0], WRITEENABLE, CLK,RESET);
    two_comp Two_Com(REGOUT2, COMPOUT);

    mux Mux1(REGOUT2, COMPOUT, COMPSELECT, MUX1);
    mux Mux2(MUX1, INSTRUCTION[7:0], IMMEDIATESELECT, ALUIN);

    alu Alu(REGOUT1, ALUIN, ALURESULT, ALUOP);

    // always @(INSTRUCTION, ALUIN, IMMEDIATESELECT)
    // $display($time, " %d %d %d", INSTRUCTION[7:0], ALUIN, IMMEDIATESELECT);

endmodule