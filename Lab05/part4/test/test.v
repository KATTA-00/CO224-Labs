
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
