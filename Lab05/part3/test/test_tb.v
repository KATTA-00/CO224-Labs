
`include "test.v"

module test_tb;

    reg RESET, CLK;
    reg [31:0] INSTRUCTION;
    wire [31:0] PC;

    reg [7:0] DATA;
    wire [7:0] OUT;

    wire WRITEENABLE, COMP_SELECT, IMMEDIATE_SELECT;
    wire [2:0] ALUOP;
    reg [7:0] OPCODE;


    cpu CPU(PC, INSTRUCTION, CLK, RESET);


    mux m(8'd1, 8'd2, 1'd0, OUT);

    control_unit c(OPCODE, WRITEENABLE, COMP_SELECT, IMMEDIATE_SELECT, ALUOP);

    // always
    // #5 CLK = ~CLK;

    initial
    #40 $finish;

    initial begin
        CLK = 0;
        $monitor($time, " %b %b %b %b %b %b >>%b - %b %b %b %b", CLK, PC, INSTRUCTION, RESET, DATA, OUT, OPCODE, WRITEENABLE, COMP_SELECT, IMMEDIATE_SELECT, ALUOP);

        $dumpfile("test.vcd");
		$dumpvars(0, test_tb);

        #5 DATA = 2;

        #5 OPCODE = 8'b00000000;
        #5 OPCODE = 8'b00000001;
        #5 OPCODE = 8'b00000010;
        #5 OPCODE = 8'b00000011;
        #5 OPCODE = 8'b00000100;
        #5 OPCODE = 8'b00000101;

    end



endmodule

module two_comp(DATA, OUT);

    input [7:0] DATA;
    output [7:0] OUT;

    assign OUT = ~DATA + 1;

endmodule

module mux(DATA1, DATA2, SELECT, OUTPUT);

    input [7:0] DATA1, DATA2;
    input SELECT;
    output reg [7:0] OUTPUT;

    always @(SELECT) begin 

        if (SELECT) 
            OUTPUT = DATA1;
        else
            OUTPUT = DATA2;

    end

endmodule