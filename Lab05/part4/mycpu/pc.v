

module pc(PC_TO, RESET, CLK, PC, PC_NEXT);

    input RESET, CLK;
    input [31:0] PC_TO;
    output reg [31:0] PC;
    
    output [31:0] PC_NEXT;
    wire [31:0] adder_out;

    pc_add pc_adder(PC, PC_NEXT);

    always @(posedge CLK) begin

        if (RESET)
            #1 PC = 32'b00000000000000000000000000000100;
        else
            #1 PC = PC_TO;
    end 

endmodule


module pc_add(PC, adder_out);

    input [31:0] PC;
    output [31:0] adder_out;

    assign #1 adder_out = PC + 4 ;

endmodule