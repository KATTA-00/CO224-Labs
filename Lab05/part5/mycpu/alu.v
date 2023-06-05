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

module alu(DATA1, DATA2, RESULT, SELECT, ZERO);

    // initailize input ports
    input [7:0] DATA1, DATA2;
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
    ALU_SL alu_sl(DATA1, DATA2, sl_result);
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
module ALU_MULT(DATA1, DATA2, OUTPUT);

    // initailize input ports
    input [7:0] DATA1, DATA2;
    reg [7:0] DATA1_, DATA2_;
    // initailize output ports
    output reg [7:0] RESULT;
    output reg [7:0] OUTPUT;

    // check the sign
    always @(DATA1, DATA2)begin
        DATA1_ = (DATA1[7] == 1'b1) ? (~DATA1 + 1) : DATA1;
        DATA2_ = (DATA2[7] == 1'b1) ? (~DATA2 + 1) : DATA2;
    end

    // get the addition of DATA1 and DATA2 
    // assign the value to RESULT with a 2 time units delay

    // declare the wires
    wire [6:0] wire0, wire1, wire2, wire3, wire4, wire5, wire6;
    wire [6:0] adderout1, adderout2, adderout3, adderout4, adderout5, adderout6;
    wire c1, c2, c3, c4, c5, c6;

    // instance the adders and add gates

    and7Bit and7bit0(DATA1_[6:0], wire0, DATA2_[0]);

    and7Bit and7bit1(DATA1_[6:0], wire1, DATA2_[1]);
    sevenBitAdder sevenbitadder1(wire1, {1'b0, wire0[6:1]}, 1'b0, adderout1, c1);

    and7Bit and7bit2(DATA1_[6:0], wire2, DATA2_[2]);
    sevenBitAdder sevenbitadder2(wire2, {c1, adderout1[6:1]}, 1'b0, adderout2, c2);

    and7Bit and7bit3(DATA1_[6:0], wire3, DATA2_[3]);
    sevenBitAdder sevenbitadder3(wire3, {c2, adderout2[6:1]}, 1'b0, adderout3, c3);

    and7Bit and7bit4(DATA1_[6:0], wire4, DATA2_[4]);
    sevenBitAdder sevenbitadder4(wire4, {c3, adderout3[6:1]}, 1'b0, adderout4, c4);

    and7Bit and7bit5(DATA1_[6:0], wire5, DATA2_[5]);
    sevenBitAdder sevenbitadder5(wire5, {c4, adderout4[6:1]}, 1'b0, adderout5, c5);

    and7Bit and7bit6(DATA1_[6:0], wire6, DATA2_[6]);
    sevenBitAdder sevenbitadder6(wire6, {c5, adderout5[6:1]}, 1'b0, adderout6, c6);

    // assign the values
    always @(DATA1, DATA2) begin
        #2  
        RESULT[0] = wire0[0];
        RESULT[1] = adderout1[0];
        RESULT[2] = adderout2[0];
        RESULT[3] = adderout3[0];
        RESULT[4] = adderout4[0];
        RESULT[5] = adderout5[0];
        RESULT[6] = adderout6[0];
        RESULT[7] = 1'b0;

        if ((DATA1[7] == 1'b1 && DATA2[7] != 1'b1) || (DATA1[7] != 1'b1 && DATA2[7] == 1'b1))
            OUTPUT = ~RESULT + 1;
        else
            OUTPUT = RESULT;
            
    end

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
// logical Shift left the give two 8 bit numbers and output a 8 bit number
// Inout  - DATA1, DATA2
// Output - RESULT
module ALU_SL(DATA1, DATA2, RESULT);

    // initailize input ports
    input [7:0] DATA1, DATA2;
    // initailize output ports
    output reg [7:0] RESULT;

    // get the logical shift
    always @(DATA1, DATA2) begin

        // assign the value
        #1 RESULT = DATA1;

        // loop time that should shift left
        for (integer i=0; i<DATA2; i=i+1) begin
            RESULT = {RESULT[6:0], 1'b0};
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


// for multiply module, additional modules
// half adder 
module HalfAdder(a, b, s, cout);

    // declare input and output
    input a,b;
    output s, cout;

    // make the half adder circuit
    xor (s, a, b);
    and (cout, a, b);

endmodule

// full adder
module FullAdder(a, b, cin, s, cout);

    // declare input and output
    input a, b, cin;
    output s, cout;
    // make the wires
    wire w1, w2, w3;

    // make two half adders to abtain the full adder
    HalfAdder H0(a,b, w1, w2);
    HalfAdder H1(w1, cin, s, w3);
    xor (cout, w2, w3);

endmodule

// 7 bit full adder
module sevenBitAdder( a, b, cin, s, cout);
    
    // declare input and output
    input [6:0] a, b;
    input cin;
    output [6:0] s;
    output cout;
    // make the wires
    wire c1, c2, c3, c4, c5, c6;

    // make four full adders to add the four bit number
    FullAdder F0(a[0], b[0], cin, s[0], c1);
    FullAdder F1(a[1], b[1], c1, s[1], c2);
    FullAdder F2(a[2], b[2], c2, s[2], c3);
    FullAdder F3(a[3], b[3], c3, s[3], c4);
    FullAdder F4(a[4], b[4], c4, s[4], c5);
    FullAdder F5(a[5], b[5], c5, s[5], c6);
    FullAdder F6(a[6], b[6], c6, s[6], cout);

endmodule

// module to amd with 7-bit number
module and7Bit(DATA, OUTPUT, BIT);

    // declare ports
    input [6:0] DATA;
    input BIT;
    output [6:0] OUTPUT;

    // declare gates
    and (OUTPUT[0], DATA[0], BIT);
    and (OUTPUT[1], DATA[1], BIT);
    and (OUTPUT[2], DATA[2], BIT);
    and (OUTPUT[3], DATA[3], BIT);
    and (OUTPUT[4], DATA[4], BIT);
    and (OUTPUT[5], DATA[5], BIT);
    and (OUTPUT[6], DATA[6], BIT);

endmodule



