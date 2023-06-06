// CO224 - Lab05 PART-3
// GROUP - 11

// include modules
`include "alu.v"
`include "reg_file.v"
`include "pc.v"
`include "control_unit.v"

// cpu module 
// that has the capacity to execute a give instruction from the instruction memory

// Inputs :
//          INSTRUCTION, CLK, RESET
// Output :
//          PC  

//cpu module

module cpu(PC, INSTRUCTION, CLK, RESET);

    input CLK, RESET;// Clock and Reset
    input [31:0] INSTRUCTION;// instruction array

    output [31:0] PC;// address of the current executing instruction

    // declare the wires
    wire ZERO;
    wire [31:0] PC_NEXT, PC_TARGET, PC_4;
    wire [2:0] ALUOP;//select bit of ALU
    wire WRITEENABLE, MUXSELECT1, MUXSELECT2, JUMP, PCSELECT, SHIFT;// control signals
    wire [1:0] BRANCH;
    wire [7:0] ALURESULT, REGOUT2, REGOUT1, COMPOUT, MUXOUT1, MUXOUT2,  IMMEDIATE, OPCODE;// declare the weires

    // extrate the immediate from the instruction
    assign IMMEDIATE = INSTRUCTION[7:0];
    // extrate the opcode from the instruction
    assign OPCODE = INSTRUCTION[31:24];

    //initialization of sub modules
    pc Pc(PC_NEXT, RESET, CLK, PC, PC_4);// initialization of Pc
    control_unit Control_Unit(OPCODE, WRITEENABLE, MUXSELECT1, MUXSELECT2, JUMP, BRANCH, ALUOP, SHIFT);// initialization of Control Unit
    reg_file Reg_File(ALURESULT, REGOUT1, REGOUT2, INSTRUCTION[18:16], INSTRUCTION[10:8], INSTRUCTION[2:0], WRITEENABLE, CLK,RESET);// initialization of register files
    two_comp Two_Com(REGOUT2, COMPOUT);// initialization of the twos compliment circuit

    // add the jump offset
    pc_adder Pc_Adder(PC_4, INSTRUCTION[23:16], PC_TARGET);

    // initialization of mux that use to select reg value or the two's compliment of reg value
    mux_8 Mux1(REGOUT2, COMPOUT, MUXSELECT1, MUXOUT1);
    // initialization of mux that use to select regster reading value or immediate values
    mux_8 Mux2(MUXOUT1, IMMEDIATE, MUXSELECT2, MUXOUT2);
    
    // wire that give input to alu
    wire [7:0] ALUIN1, ALUOUT;
    // initialization of reverse mux before alu
    mux_revers Mux_Revers1(REGOUT1, ALUIN1, SHIFT);
    // declare the alu unit
    alu Alu(ALUIN1, MUXOUT2, ALUOUT, ALUOP, ZERO);
    // initialization of reverse mux after alu
    mux_revers Mux_Revers2(ALUOUT, ALURESULT, SHIFT);

    // to get the selection bit for branch
    wire WIRE1;
    mux_branch MuxBranch(ZERO, BRANCH, WIRE1);
    // Select pc + offset when both jump and branch
    or(PCSELECT, JUMP, WIRE1);

    // mux to choose between pc+4 and branch target
    mux_32 Mux3(PC_4, PC_TARGET, PCSELECT, PC_NEXT);

endmodule
