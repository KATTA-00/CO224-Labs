// CO224 - Lab05 PART-3
// GROUP - 11
`timescale 1ns/100ps

// program counter module
module pc(PC_TO, RESET, CLK, PC, PC_NEXT, HOLD);

    // declare ports
    input RESET, CLK, HOLD;
    input [31:0] PC_TO;
    output reg [31:0] PC;// reg to hold the address of the current executing instruction
    
    output [31:0] PC_NEXT;// next instruction to be executed
    wire [31:0] adder_out;// address of the next instruction to be executed

    // output from the PC adder (adderout = PC+4)
    pc_add pc_adder(PC, PC_NEXT);

    always @(posedge CLK) begin
        // at every positive edge of the clock
        // if reset is enabled, 0 is written to PC
        // else Next address is written to PC 

        // adding the delay
        #0.001
        if (RESET)
            #0.999 PC = 32'b00000000000000000000000000000000;
        else if(~HOLD) begin
            // write the next instruction address
            #0.999 PC = PC_TO;
        end
    end 

endmodule


//pc adder module (adder_out = PC+4(because word size is 4 bytes))
module pc_add(PC, adder_out);

    // declare ports
    input [31:0] PC;
    output [31:0] adder_out;

    // Incremtn the value by 4 and assing it the output with a delay of 1
    assign #1 adder_out = PC + 4 ;

endmodule