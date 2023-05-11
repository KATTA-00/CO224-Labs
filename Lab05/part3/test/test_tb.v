
`include "test.v"

module test_tb;

    reg RESET, CLK;
    reg [31:0] INSTRUCTION;
    wire [31:0] PC;

    reg [7:0] DATA;
    wire [7:0] OUT;


    cpu CPU(PC, INSTRUCTION, CLK, RESET);


    mux m(8'd1, 8'd2, 1'd0, OUT);

    always
    #5 CLK = ~CLK;

    initial
    #30 $finish;

    initial begin
        CLK = 0;
        $monitor($time, " %b %b %b %b %b %b", CLK, PC, INSTRUCTION, RESET, DATA, OUT);

        $dumpfile("test.vcd");
		$dumpvars(0, test_tb);

        #8 DATA = 2;

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