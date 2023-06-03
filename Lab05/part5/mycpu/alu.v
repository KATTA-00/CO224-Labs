// CO224 - Lab05 PART-1
// GROUP - 11

// ALU module 
// 8-bit ALU unit, that can operate with two 8-bit numbers to generate the result
// give the relevant output to RESULT respect to SELECT 

// Input:
//      DATA1, DATA2, SELECT
// Output:
//      RESULT

// Operations:
//      FORWARD - forward the data in DATA2 into RESULT 
//      ADD     - add DATA1 and DATA2, give the addiction to RESULT
//      AND     - and DATA1 and DATA2, give the result to RESULT     
//      OR      - or DATA1 and DATA2, give the result to RESULT  
//      MULT    - multiply DATA1 and DATA2, give the result to RESULT  
//      SLL     - logical left shift DATA1, give the result to RESULT  
//      SRL     - logical right shoft DATA1, give the result to RESULT  
//      SRA     - Arithmetic shoft right DATA1, give the result to RESULT  
//      ROR     - Rotate right DATA1, give the result to RESULT  

// SELECTION CODE:
//      FOEWARD - 000   
//      ADD     - 001
//      AND     - 010   
//      OR      - 011
//      MULT    - 100
//      SL      - 101
//      SRA     - 110
//      ROR     - 111

module alu(DATA1, DATA2, RESULT, SELECT, ZERO, SHIFT);

    // initailize input ports
    input [7:0] DATA1, DATA2;
    // input the shift left signal
    input SHIFT;
    input [0:2] SELECT;
    // initailize output ports
    output [7:0] RESULT;
    output ZERO;

    // make wires for connect each module's outputs to the mux
    wire [7:0] forward_result, add_result, and_result, or_result, mult_result, sra_result, sl_result, ror_result;

    // make instances of for each module
    // FORWARD - alu_forward
    // ADD     - alu_add
    // AND     - alu_and
    // OR      - alu_or
    // MULT    - alu_mult
    // SL      - alu_sl
    // SRA     - alu_sra
    // ROR     - alu_ror
    // connect each module's relevant input and output
    ALU_FORWARD alu_forward(DATA2, forward_result);
    ALU_ADD alu_add(DATA1, DATA2, add_result);
    ALU_AND alu_and(DATA1, DATA2, and_result);
    ALU_OR alu_or(DATA1, DATA2, or_result);
    ALU_MULT alu_mult(DATA1, DATA2, mult_result);
    ALU_SRA alu_sra(DATA1, DATA2, sra_result);
    ALU_SL alu_sl(DATA1, DATA2, SHIFT, sl_result);
    ALU_ROR alu_ror(DATA1, DATA2, ror_result);

    // get the zero signal
    ZERO_SIGNAL zero_signal(add_result, ZERO);
    

    // instantiation of the mux
    // connect all the the module's output to the mux 
    // select a input as the selection
    MUX mux(forward_result, add_result, and_result, or_result, mult_result, sra_result, sl_result, ror_result, RESULT, SELECT);

endmodule

// Module to get to ZERO signal
module ZERO_SIGNAL(add_result, ZERO);

    // initailize input ports
    input [7:0] add_result;
    // output port
    output ZERO;

    // assign the zero value
    assign ZERO =  (add_result == 0)  ? 1'b1 : 1'b0;

endmodule


// FORWARD module
// used to foward the 8 bit DATA2 directly to output of the module
// Inputs  - DATA2
// Outputs - RESULT
module ALU_FORWARD(DATA2, RESULT);

    // initailize input ports
    input [7:0] DATA2;
    // initailize output ports
    output [7:0] RESULT;

    // assigen the DATA2 value to RESULT with a 1 time unit delay
    assign #1 RESULT = DATA2;

endmodule


// ADD module
// 8 bit adder for add two 8 bit number and give a 8 bit result
// Inputs - DATA1, DATA2
// Output - RESULT
module ALU_ADD(DATA1, DATA2, RESULT);

    // initailize input ports
    input [7:0] DATA1, DATA2;
    // initailize output ports
    output [7:0] RESULT;

    // get the addition of DATA1 and DATA2 
    // assign the value to RESULT with a 2 time units delay
    assign #2 RESULT = DATA1 + DATA2;

endmodule

// MULT module
// 8 bit multipler for mult two 8 bit number and give a 8 bit result
// Inputs - DATA1, DATA2
// Output - RESULT
module ALU_MULT(DATA1, DATA2, RESULT);

    // initailize input ports
    input [7:0] DATA1, DATA2;
    // initailize output ports
    output [7:0] RESULT;

    // get the addition of DATA1 and DATA2 
    // assign the value to RESULT with a 2 time units delay
    assign #2 RESULT = DATA1 * DATA2;

endmodule


// AND module
// bitwise AND the give two 8 bit numbers and output a 8 bit number
// Inout  - DATA1, DATA2
// Output - RESULT
module ALU_AND(DATA1, DATA2, RESULT);

    // initailize input ports
    input [7:0] DATA1, DATA2;
    // initailize output ports
    output [7:0] RESULT;

    // AND bitwise each bit
    // assign it to RESULT with a 1 time unit delay
    assign #1 RESULT = DATA1 & DATA2;

endmodule


// OR module
// bitwise OR the give two 8 bit numbers and output a 8 bit number
// Inout  - DATA1, DATA2
// Output - RESULT
module ALU_OR(DATA1, DATA2, RESULT);

    // initailize input ports
    input [7:0] DATA1, DATA2;
    // initailize output ports
    output [7:0] RESULT;

    // and bitwise each bit
    // assign it to RESULT with a 1 time unit delay
    assign #1 RESULT = DATA1 | DATA2;

endmodule

// SRA module
// Arithmetic Shift Right the give two 8 bit numbers and output a 8 bit number
// Inout  - DATA1, DATA2
// Output - RESULT
module ALU_SRA(DATA1, DATA2, RESULT);

    // initailize input ports
    input [7:0] DATA1, DATA2;
    // initailize output ports
    output reg [7:0] RESULT;

    // get the arithmetic shift right
    always @(DATA1, DATA2) begin

        // assign the value
        #1 RESULT = DATA1;

        // loop time that should shift
        for (integer i=0; i<DATA2; i=i+1) begin
            RESULT = {DATA1[7], RESULT[7:1]};
        end

    end

endmodule

// SL module
// logical Shift left and right the give two 8 bit numbers and output a 8 bit number
// Inout  - DATA1, DATA2
// Output - RESULT
module ALU_SL(DATA1, DATA2, SHIFT, RESULT);

    // initailize input ports
    input [7:0] DATA1, DATA2;
    input SHIFT;
    // initailize output ports
    output reg [7:0] RESULT;

    // get the logical shift
    // get the shift
    always @(DATA1, DATA2, SHIFT) begin

        // assign the value
        #1 RESULT = DATA1;

        if (SHIFT) begin
            // loop time that should shift left
            for (integer i=0; i<DATA2; i=i+1) begin
                RESULT = {RESULT[6:0], 1'b0};
            end
        end else begin
            // loop time that should shift right
            for (integer i=0; i<DATA2; i=i+1) begin
                RESULT = {1'b0, RESULT[7:1]};
            end
        end

    end

endmodule

// ROR module
// rortate right the give two 8 bit numbers and output a 8 bit number
// Inout  - DATA1, DATA2
// Output - RESULT
module ALU_ROR(DATA1, DATA2, RESULT);

    // initailize input ports
    input [7:0] DATA1, DATA2;
    // initailize output ports
    output reg [7:0] RESULT;

    // get the rortate
    always @(DATA1, DATA2) begin

        // assign the value
        #1 RESULT = DATA1;

        // loop time that should rotate
        for (integer i=0; i<DATA2; i=i+1) begin
            RESULT = {RESULT[0], RESULT[7:1]};
        end

    end

endmodule


// MUX module
// select a inputs for the inputs
// map it to the ouput reference to the selection bits
// Inputs  - forward_result, add_result, and_result, or_result, SELECT
// Outputs - RESULT
module MUX(forward_result, add_result, and_result, or_result, mult_result, sra_result, sl_result, ror_result, RESULT, SELECT);

    // initailize input ports
    input [7:0] forward_result, add_result, and_result, or_result, mult_result, sra_result, sl_result, ror_result;
    input [2:0] SELECT;
    // initailize output ports
    output reg [7:0] RESULT;

    // set a always block to trigger when changing 
    // forward_result, add_result, and_result, or_result, SELECT
    // thus, if these inputs are change the output is change reference to selection bits
    always @(forward_result, add_result, and_result, or_result, mult_result, sra_result, sl_result, ror_result, SELECT) begin
        
        // case block to check the select bit
        // give the result value 
        case(SELECT)

            // selection for FORWARD
            3'b000 : RESULT = forward_result;
            // selection for ADD
            3'b001 : RESULT = add_result;
            // selection for AND
            3'b010 : RESULT = and_result;
            // selection for OR
            3'b011 : RESULT = or_result;
            // selection for MULT
            3'b100 : RESULT = mult_result;
            // selection of logical shift
            3'b101 : RESULT = sl_result;
            // selection of SRA
            3'b110 : RESULT = sra_result;
            // selection of ROR
            3'b111 : RESULT = ror_result;

            // deafult routing
            default : RESULT = 0;
        endcase

    end

endmodule


