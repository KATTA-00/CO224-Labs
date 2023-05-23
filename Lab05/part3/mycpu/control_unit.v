// CO224 - Lab05 PART-3
// GROUP - 11

// Control Unit
// To decode the OpCode and make the control signals

module control_unit(OPCODE, WRITEENABLE, COMP_SELECT, IMMEDIATE_SELECT, ALUOP);

    // declaration of input output retisters
    input [7:0] OPCODE; 
    output reg WRITEENABLE, COMP_SELECT, IMMEDIATE_SELECT; //control signal
    output reg [2:0] ALUOP; // control signal for ALU (2 bit signal)

    always @(OPCODE) begin 

        #1
        //enabling the control signals according to the OPCODE
        case (OPCODE)
            // loadi - load the register with the given immediate value 
            8'b0000_0000: begin
                WRITEENABLE = 1'b1; // control signal to write to the register
                COMP_SELECT = 1'b0; 
                IMMEDIATE_SELECT = 1'b1; // immediate number select
                ALUOP = 3'b000; // select forward result from ALU
            end

            //mov - copy a value in a register to another register
            8'b0000_0001: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b000;
            end

            // add - add 2 register values and write the result to another register
            8'b0000_0010: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b001; //select add result from alu
            end

            // sub - subtract 2 reg values and write the result to another register
            8'b0000_0011: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b1; // 2s complement enables(input for aku module is 2's complemented)
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b001; // select add from ALU
            end

            // and - bitwise AND of 2 reg values
            8'b0000_0100: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b010; // select and result form alu
            end

            // or - bitwise OR of 2 reg values
            8'b0000_0101: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b011; // select or result from ALU
            end

        endcase

    end

endmodule