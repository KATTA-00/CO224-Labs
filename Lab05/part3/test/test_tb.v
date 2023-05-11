
`include "test.v"

module test_tb;

    reg RESET, CLK;
    reg [31:0] INSTRUCTION;
    wire [31:0] PC;

    cpu CPU(PC, INSTRUCTION, CLK, RESET);

    always
    #5 CLK = ~CLK;

    initial
    #30 $finish;

    initial begin
        CLK = 0;
        $monitor($time, " %b %b %b %b", CLK, PC, INSTRUCTION, RESET);

        $dumpfile("test.vcd");
		$dumpvars(0, test_tb);
    end



endmodule