module two_comp(DATA, OUT);

    input [7:0] DATA;
    output [7:0] OUT;

    assign #1 OUT = ~DATA + 1;

endmodule


module mux(DATA1, DATA2, SELECT, OUTPUT);

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
