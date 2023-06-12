// CO224 - Lab05 PART-3
// GROUP - 11

// Control Unit
// To decode the OpCode and make the control signals

module control_unit(OPCODE, WRITEENABLE, COMP_SELECT, IMMEDIATE_SELECT, JUMP, BRANCH, ALUOP, REVERSE, READ, WRITE, BUSYWAIT, HOLD, MEM_SELECT);

    // declaration of input output retisters
    input [7:0] OPCODE;
    input BUSYWAIT;
    output reg WRITEENABLE, COMP_SELECT, IMMEDIATE_SELECT, JUMP, REVERSE, READ, WRITE, MEM_SELECT;    //control signal
    output HOLD;
    output reg [1:0] BRANCH;
    output reg [2:0] ALUOP;// control signal for ALU (2 bit signal)

    // busywait signal
    assign HOLD = BUSYWAIT;

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
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end

            //mov - copy a value in a register to another register
            8'b0000_0001: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b000;
                JUMP = 1'b0;
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end

            // add - add 2 register values and write the result to another register
            8'b0000_0010: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b001;//select add result from alu
                JUMP = 1'b0;
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end

            // mult - mult 2 register values and write the result to another register
            8'b0000_1100: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b100; // select mult result from alu
                JUMP = 1'b0;
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end

            // sub - subtract 2 reg values and write the result to another register
            8'b0000_0011: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b1;
                IMMEDIATE_SELECT = 1'b0;// 2s complement enables(input for aku module is 2's complemented)
                ALUOP = 3'b001;// select add from ALU
                JUMP = 1'b0;
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end

            // and - bitwise AND of 2 reg values
            8'b0000_0100: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b010;// select and result form alu
                JUMP = 1'b0;
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end

            // or - bitwise OR of 2 reg values
            8'b0000_0101: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0; 
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b011;// select or result from ALU
                JUMP = 1'b0;
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end


            // sll - logical shift left a reg velue
            8'b0000_1101: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0; 
                IMMEDIATE_SELECT = 1'b1;
                ALUOP = 3'b101;     // select or result from ALU
                JUMP = 1'b0;
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end

            // srl - logical shift left a reg velue
            8'b0000_1110: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0; 
                IMMEDIATE_SELECT = 1'b1;
                ALUOP = 3'b101;     // select or result from ALU
                JUMP = 1'b0;
                BRANCH = 2'b00; // branch
                REVERSE = 1'b1; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end

            // sra - arithmetic shift right a reg velue
            8'b0000_1111: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0; 
                IMMEDIATE_SELECT = 1'b1;
                ALUOP = 3'b110;     // select or result from ALU
                JUMP = 1'b0;
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end

            // ror - arithmetic shift right a reg velue
            8'b0001_0000: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0; 
                IMMEDIATE_SELECT = 1'b1;
                ALUOP = 3'b111;     // select or result from ALU
                JUMP = 1'b0;
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end

            // j - jump instruction relative to the next instruction to execute
            8'b0000_0110: begin
                WRITEENABLE = 1'b0;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b000;
                JUMP = 1'b1; // jump is enable
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end
            
            // beq - branch if reg values are eqaul
            8'b0000_0111: begin
                WRITEENABLE = 1'b0;
                COMP_SELECT = 1'b1;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b001;
                JUMP = 1'b0; // jump is disable
                BRANCH = 2'b01; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end

            // bne - branch if reg values are eqaul
            8'b0001_0001: begin
                WRITEENABLE = 1'b0;
                COMP_SELECT = 1'b1;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b001;
                JUMP = 1'b0; // jump is disable
                BRANCH = 2'b10; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b0;
                MEM_SELECT = 1'b0;
            end

            // lwd - load word, address and value are in registers
            8'b0000_1000: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b000;
                JUMP = 1'b0; // jump is disable
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b1;    // read from memory
                WRITE = 1'b0;
                MEM_SELECT = 1'b1;
            end

            // lwi - load word, address is give as immediate
            8'b0000_1001: begin
                WRITEENABLE = 1'b1;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b1;
                ALUOP = 3'b000;
                JUMP = 1'b0; // jump is disable
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b1;    // read from memory
                WRITE = 1'b0;
                MEM_SELECT = 1'b1;
            end

            // swd - store word, address and value are in registers
            8'b0000_1010: begin
                WRITEENABLE = 1'b0;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b0;
                ALUOP = 3'b000;
                JUMP = 1'b0; // jump is disable
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b1;   // write to memory
                MEM_SELECT = 1'b0;
            end

            // swi - address is give as immediate
            8'b0000_1011: begin
                WRITEENABLE = 1'b0;
                COMP_SELECT = 1'b0;
                IMMEDIATE_SELECT = 1'b1;
                ALUOP = 3'b000;
                JUMP = 1'b0; // jump is disable
                BRANCH = 2'b00; // branch
                REVERSE = 1'b0; // shift right signal(reverse signal)
                READ = 1'b0;
                WRITE = 1'b1;   // write to memory
                MEM_SELECT = 1'b0;
            end
            
        endcase
                
    end

endmodule
