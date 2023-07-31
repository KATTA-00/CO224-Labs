// CO224 - Lab05 PART-3
// GROUP - 11

// Control Unit
// To decode the OpCode and make the control signals

module control_unit(OPCODE, WRITEENABLE, COMP_SELECT, IMMEDIATE_SELECT, JUMP, BRANCH, ALUOP);

    // declaration of input output registers
    input [7:0] OPCODE;
    output reg WRITEENABLE, COMP_SELECT, IMMEDIATE_SELECT, JUMP, BRANCH;//control signal
    output reg [2:0] ALUOP;// control signal for ALU (2 bit signal)

    always @(OPCODE) begin 

        // delay of the dedcoding
        #1
        //enabling the control signals according to the OPCODE
        case (OPCODE)
        // loadi - load the register with the given immediate value 
            8'b0000_0000: begin
                WRITEENABLE = 1'b1;// control signal to write to the register
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b1;// immediate number select
                ALUOP = 3'b000;// select forward result from ALU
                JUMP = 1'b0; // jump
                BRANCH = 1'b0; // branch
            end

            //mov - copy a value in a register to another register
            8'b0000_0001: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b000;
                JUMP = 1'b0;
                BRANCH = 1'b0;
            end

            // add - add 2 register values and write the result to another register
            8'b0000_0010: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b001;//select add result from alu
                JUMP = 1'b0;
                BRANCH = 1'b0;
            end

            // sub - subtract 2 reg values and write the result to another register
            8'b0000_0011: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b1;
                IMMEDIATE_SELECT = 1'b0;// 2s complement enables(input for aku module is 2's complemented)
                ALUOP = 3'b001;// select add from ALU
                JUMP = 1'b0;
                BRANCH = 1'b0;
            end

            // and - bitwise AND of 2 reg values
            8'b0000_0100: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b010;// select and result form alu
                JUMP = 1'b0;
                BRANCH = 1'b0;
            end

            // or - bitwise OR of 2 reg values
            8'b0000_0101: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0; 
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b011;// select or result from ALU
                JUMP = 1'b0;
                BRANCH = 1'b0;
            end

            // j - jump to a instruction relative to the next instruction to be executed
            8'b0000_0110: begin
                WRITEENABLE = 1'b0;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b000;
                JUMP = 1'b1; // jump is enable
                BRANCH = 1'b0; // branch is disable
            end
            
            // beq - branch if reg values are eqaul
            8'b0000_0111: begin
                WRITEENABLE = 1'b0;
                COMP_SELECT = 1'b1;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b001;
                JUMP = 1'b0; // jump is disable
                BRANCH = 1'b1; // branch is enable
            end
            
        endcase

                
    end

endmodule
