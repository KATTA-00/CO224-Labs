
module cpu(PC, INSTRUCTION, CLK, RESET);

    input CLK, RESET;
    input [31:0] INSTRUCTION;

    output [31:0] PC;

    pc p(RESET, CLK, PC);

endmodule

module control_unit(OPCODE, WRITEENABLE, COMP_SELECT, IMMEDIATE_SELECT, ALUOP);

    input [7:0] OPCODE;
    output reg WRITEENABLE, COMP_SELECT, IMMEDIATE_SELECT;
    output reg [2:0] ALUOP;

    always @(OPCODE) begin 

        #1

        case (OPCODE)
            8'b0000_0000: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b1;
                ALUOP = 3'b000;
            end

            8'b0000_0001: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b000;
            end

            8'b0000_0010: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b001;
            end

            8'b0000_0011: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b1;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b001;
            end

            8'b0000_0100: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b010;
            end

            8'b0000_0101: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b011;
            end

        endcase

    end

endmodule

module pc(RESET, CLK, PC);

    input RESET, CLK;
    output reg [31:0] PC;
    
    reg [31:0] PC_NEXT;
    wire [31:0] adder_out;

    pc_add pc_adder(PC, adder_out);

    initial
    PC = 0;

    always @(adder_out)
    PC_NEXT = adder_out;

    always @(posedge CLK) begin
        #1 PC = PC_NEXT;
    end 

endmodule

module pc_add(PC, adder_out);

    input [31:0] PC;
    output [31:0] adder_out;

    assign #1 adder_out = PC + 1;

endmodule


@ sll 2 1 0x05
@ srl 3 0 0x02
@ bne 0x01 1 0
@ loadi 2 0x01   // r1 = 9
@ beq 0x08 1 2
@ j 0x03
@ beq 0x02 1 2
@ mov 2 1        // r2 = r1
@ add 3 2 0      // r3 = r2 + r0
@ sub 4 3 1      // r4 = r3 + r1
@ loadi 0 0x75   // r0 = 0x75
@ loadi 1 0x92   // r1 = 0x92
@ and 5 1 0      // r5 = r1 & r0
@ or 6 5 2       // r6 = r5 | r2
@ and 5 1 2      // r5 = r1 & r0
