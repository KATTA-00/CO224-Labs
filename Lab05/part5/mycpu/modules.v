// CO224 - Lab05 PART-3
// GROUP - 11

// this file contains two's compliment unit and mux unit
// two_comp - get a 8 bit data and output its 2's compliment
// mux8 - used to select two 8 bit data with a selection bit
// mux32 - used to select two 32 bit data with a selection bit
// pc_adder - used to add the offset in jump/branch instruction

// module for get the 2's complwment required for sub instruction
module two_comp(DATA, OUT);

    input [7:0] DATA;
    output [7:0] OUT;

    //assign 2's complement of the data to thw output
    assign #1 OUT = ~DATA + 1;

endmodule

//2x1 1-bit mux module for get the branch signal
module mux_branch(DATA1, SELECT, OUTPUT);

    input DATA1; // input data to the mux
    input [1:0] SELECT; // selector bit
    output reg OUTPUT; // output from the mux

    // select whether to branch or not
    // if the branch equal signal is on the pass the zero signal 
    // if the branch not equal signal is on the pass the not zero signal 
    // if branch is zero the output 1'b0
    always @(DATA1, SELECT) begin 

        case(SELECT)

            2'b00: OUTPUT = 1'b0;

            2'b01: OUTPUT = DATA1;

            2'b10: OUTPUT = ~DATA1;

        endcase

    end

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

// module to revers a 8-bit bit stream
// if SELECT  = 1, the reverse or not
module revers(DATA, OUTPUT, SELECT);

    // declare ports
    input SELECT;
    input [7:0] DATA;
    output reg [7:0] OUTPUT;

    // if SELECT = 1, give the reversed data
    // if SELECT = 0, give the data
    always @(DATA, SELECT) begin 
        if (SELECT) begin //select = 1, data revers
            for (integer i=0; i<8; i++)
                OUTPUT[i] = DATA[7-i];
        end
        else // else data is selected
            OUTPUT = DATA;
    end

endmodule