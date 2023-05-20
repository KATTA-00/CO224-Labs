// CO224 - Lab05 PART-3
// GROUP - 11

// Control Unit
// To decode the OpCode and make the control signals

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