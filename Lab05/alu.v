
// ALU module 
// get two inputs as DATA1 and DATA2 
// give the relevant output to RESULT respect to SELECT 
module alu(DATA1, DATA2, RESULT, SELECT);

    input [7:0] DATA1, DATA2;
    input [0:2] SELECT;
    output [7:0] RESULT;

    wire [7:0] forward_result, add_result, and_result, or_result;

    ALU_FORWARD alu_forward(DATA2, forward_result);
    ALU_ADD alu_add(DATA1, DATA2, add_result);
    ALU_AND alu_and(DATA1, DATA2, and_result);
    ALU_OR alu_or(DATA1, DATA2, or_result);

    MUX mux(forward_result, add_result, and_result, or_result, RESULT, SELECT);

endmodule


// forward module
module ALU_FORWARD(DATA2, RESULT);

    input [7:0] DATA2;
    output [7:0] RESULT;

    assign #1 RESULT = DATA2;

endmodule


// adder module
module ALU_ADD(DATA1, DATA2, RESULT);

    input [7:0] DATA1, DATA2;
    output [7:0] RESULT;

    assign #2 RESULT = DATA1 + DATA2;

endmodule


// and module
module ALU_AND(DATA1, DATA2, RESULT);

    input [7:0] DATA1, DATA2;
    output [7:0] RESULT;

    assign #1 RESULT = DATA1 & DATA2;

endmodule


// or module
module ALU_OR(DATA1, DATA2, RESULT);

    input [7:0] DATA1, DATA2;
    output [7:0] RESULT;

    assign #1 RESULT = DATA1 | DATA2;

endmodule


// mux module
module MUX(forward_result, add_result, and_result, or_result, RESULT, SELECT);

    input [7:0] forward_result, add_result, and_result, or_result;
    input [2:0] SELECT;
    output [7:0] RESULT;
    reg [7:0] RESULT;

    always @(forward_result, add_result, and_result, or_result, SELECT) begin
        
        case(SELECT)

            3'b000 : RESULT = forward_result;
            3'b001 : RESULT = add_result;
            3'b010 : RESULT = and_result;
            3'b011 : RESULT = or_result;

            default : RESULT = 0;

        endcase

    end

endmodule



