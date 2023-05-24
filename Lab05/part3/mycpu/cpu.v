// CO224 - Lab05 PART-3
// GROUP - 11

// include modules 
`include "alu.v"
`include "reg_file.v"
`include "pc.v"
`include "control_unit.v"
`include "modules.v"

// cpu module 
// that has the capacity to execute a give instruction from the instruction memory

// Inputs :
//          INSTRUCTION, CLK, RESET
// Output :
//          PC  



module cpu(PC, INSTRUCTION, CLK, RESET);

    input CLK, RESET;
    input [31:0] INSTRUCTION;

    output [31:0] PC;

    wire [2:0] ALUOP;
    wire WRITEENABLE, COMPSELECT, IMMEDIATESELECT;
    wire [7:0] ALURESULT, REGOUT2, REGOUT1, COMPOUT, MUX1, ALUIN;


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