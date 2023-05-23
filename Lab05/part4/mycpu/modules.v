module two_comp(DATA, OUT);

    input [7:0] DATA;
    output [7:0] OUT;

    assign #1 OUT = ~DATA + 1;

endmodule


module mux_8(DATA1, DATA2, SELECT, OUTPUT);

    input [7:0] DATA1, DATA2;
    input SELECT;
    output reg [7:0] OUTPUT;

    always @(DATA1, DATA2, SELECT) begin 

        if (SELECT) 
            OUTPUT = DATA2;
        else
            OUTPUT = DATA1;

    end

endmodule

module mux_32(DATA1, DATA2, SELECT, OUTPUT);

    input [31:0] DATA1, DATA2;
    input SELECT;
    output reg [31:0] OUTPUT;

    always @(DATA1, DATA2, SELECT) begin 

        if (SELECT) 
            OUTPUT = DATA2;
        else
            OUTPUT = DATA1;

    end

endmodule

module pc_adder(DATA1, DATA2, RESULT);

    input [31:0] DATA1;
    input [7:0] DATA2;
    output [31:0] RESULT;

    assign #2 RESULT = DATA1 + DATA2 * 4;

endmodule