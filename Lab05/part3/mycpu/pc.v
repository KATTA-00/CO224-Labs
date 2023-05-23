
// program counter module
module pc(RESET, CLK, PC);

    input RESET, CLK;
    output reg [31:0] PC; // reg to hold the address of the current executing instruction
    
    reg [31:0] PC_NEXT; // next instruction to be executed
    wire [31:0] adder_out; // address of the next instruction to be executed

    // output from the PC adder (adderout = PC+4)
    pc_add pc_adder(PC, adder_out);

    always @(adder_out) // if pc adder output changes, adder out is assigned to the next instruction address 
    PC_NEXT = adder_out;

    always @(posedge CLK) begin
        // at every positive edge of the clock
        // if reset is enabled, 0 is written to PC
        // else Next address is written to PC 
        if (RESET)
            #1 PC = 32'b00000000000000000000000000000000;
        else
            #1 PC = PC_NEXT;
    end 

endmodule

//pc adder module (adder_out = PC+4(because word size is 4 bytes))
module pc_add(PC, adder_out);

    input [31:0] PC;
    output [31:0] adder_out;

    assign #1 adder_out = PC + 4 ;

endmodule