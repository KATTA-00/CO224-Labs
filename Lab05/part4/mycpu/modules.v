// CO224 - Lab05 PART-3
// GROUP - 11

// this file contains two's compliment unit and mux unit
// two_comp - get a 8 bit data and output its 2's compliment
// mux - used to select two 8 bit data with a selection bit

// module for get the 2's complwment required for sub instruction
module two_comp(DATA, OUT);

    input [7:0] DATA;
    output [7:0] OUT;

    //assign 2's complement of the data to thw output
    assign #1 OUT = ~DATA + 1;

endmodule

//2x1 8-bit mux module for transfer data
module mux_8(DATA1, DATA2, SELECT, OUTPUT);

    input [7:0] DATA1, DATA2; // input data to the mux
    input SELECT; // selector bit
    output reg [7:0] OUTPUT; // output from the mux

    always @(DATA1, DATA2, SELECT) begin 

        if (SELECT) //select= 1, data 2 is selected from the mux
            OUTPUT = DATA2;
        else // else data 1 is selected
            OUTPUT = DATA1;

    end

endmodule

//2x1 32-bit mux module for transfer data
module mux_32(DATA1, DATA2, SELECT, OUTPUT);

    input [31:0] DATA1, DATA2; // input data to the mux
    input SELECT; // selector bit
    output reg [31:0] OUTPUT; // output from the mux

    always @(DATA1, DATA2, SELECT) begin 

        if (SELECT) //select= 1, data 2 is selected from the mux
            OUTPUT = DATA2;
        else // else data 1 is selected
            OUTPUT = DATA1;

    end

endmodule

// adder to add the offset of the jump/branch instruction
module pc_adder(DATA1, DATA2, RESULT);

    // declare the ports
    input signed [31:0] DATA1;
    input signed [7:0] DATA2;
    output [31:0] RESULT;

    // assign the added value
    assign #2 RESULT = DATA1 + DATA2 * 4;

endmodule