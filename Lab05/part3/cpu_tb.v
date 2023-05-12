`include "cpu.v"

module cpu_tb;

    reg RESET, CLK;
    wire [31:0] INSTRUCTION;
    wire [31:0] PC;

    cpu CPU(PC, INSTRUCTION, CLK, RESET);

    reg [31:0] instr_mem [255:0];

    assign #2 INSTRUCTION = instr_mem[PC];

    initial begin
        CLK = 0;
        RESET = 0;
        $monitor($time, " %b %b %b %b", PC, INSTRUCTION, CLK, RESET);

        $dumpfile("cpu_tb.vcd");
		$dumpvars(0, cpu_tb);

        #40 $finish;
    end

    initial begin
        // instr_mem[0] = 0;

        instr_mem[0] = 32'b00000001_00000001_00000011_00000010;
        instr_mem[1] = 32'b00000000_00000010_00000000_00000011;
        instr_mem[2] = 32'b00000000_00000001_00000000_00000010;
    end

    always
    #4 CLK = ~CLK;


endmodule

