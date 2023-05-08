// CO224 - Lab05 PART-1
// GROUP - 11
// Test bench for test ALU module

// include the alu module
`include "alu.v"

// test bench module for alu
module alu_tb;

    // declate the registers
    reg [7:0] DATA1, DATA2;
    reg [2:0] SELECT;
    // declare the wires
    wire [7:0] RESULT;

    // make the instance of the alu module
    alu ALU(DATA1, DATA2, RESULT, SELECT);

    // set the monitor to abserve the values
    initial begin
        $monitor($time, " SELECT = %b | DATA1 = %b, DATA2 = %b and RESULT = %b",SELECT, DATA1, DATA2, RESULT);

        // generate files needed to plot the waveform using GTKWave
        $dumpfile("alu_tb_waveform.vcd");
		$dumpvars(0, alu_tb);
    end

    // change the values and check the outputs
    initial begin
        // initiale values
        SELECT = 3'b000; 
        DATA1 = 8'b0000_0000; 
        DATA2 = 8'b0000_0000;

        // FORWARD functionality
        #5
        SELECT = 3'b000; 6
        DATA1 = 8'b0000_0010; 
        DATA2 = 8'b0000_0001;
        
        // ADD funcationality
        #5
        SELECT = 3'b001; 
        DATA1 = 8'b0000_0001; 
        DATA2 = 8'b0000_0001;

        // AND funcationality
        #5
        SELECT = 3'b010; 
        DATA1 = 8'b0000_1111; 
        DATA2 = 8'b0000_0011;
        
        // OR funcationality
        #5
        SELECT = 3'b011; 
        DATA1 = 8'b0000_1001; 
        DATA2 = 8'b0000_1100;

        // change the selection only
        #5
        SELECT = 3'b001; 

        // change DATA1 only
        #5 
        DATA1 = 8'b0010_1000; 

        // change DATA2 only
        #5
        DATA2 = 8'b0000_0011;

        // AND funcationality
        #5
        SELECT = 3'b010; 
        DATA1 = 8'b0000_1001; 
        DATA2 = 8'b0000_1100;

    end

endmodule
