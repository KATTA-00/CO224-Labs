
module cpu(PC, INSTRUCTION, CLK, RESET);

    input CLK, RESET;
    input [31:0] INSTRUCTION;

    output [31:0] PC;

    pc p(RESET, CLK, PC);

endmodule

// module control_unit;



// endmodule

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
