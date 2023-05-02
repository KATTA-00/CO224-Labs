// ALU module 
// get two inputs as DATA1 and DATA2 
// give the relevant output to RESULT respect to SELECT 
module alu(DATA1, DATA2, RESULT, SELECT);

    input [7:0] DATA1, DATA2;
    input [0:2] SELECT;
    output [7:0] RESULT;

    reg [7:0] RESULT;

    wire [7:0] addRsult;

    ADD add(DATA1, DATA2, addRsult);

    always @(DATA1, DATA2, SELECT) begin
        
        case(SELECT)
            3'b001 : RESULT = addRsult;

            default : RESULT = 0;
        endcase

    end

endmodule


module ADD(DATA1, DATA2, RESULT);

    input [7:0] DATA1, DATA2;
    output [7:0] RESULT;

    assign #2 RESULT = DATA1 + DATA2;

endmodule



