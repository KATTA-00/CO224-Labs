module reg_file(IN,OUT1,OUT2,INADDRESS,OUT1ADDRESS,OUT2ADDRESS, WRITE, CLK, RESET);

    input [7:0] IN;
    input [2:0]  INADDRESS, OUT1ADDRESS, OUT2ADDRESS;
    input  WRITE, CLK, RESET;

    output [7:0] OUT1, OUT2;
    reg [7:0] OUT2;

    reg [7:0] registers [7:0];

    // always @(OUT1ADDRESS,  registers[0],registers[1],registers[2],registers[3],registers[4],registers[5],registers[6],registers[7]) begin
        
    //     case(OUT1ADDRESS)

    //         3'b000: #2 OUT1 = registers[0];
    //         3'b001: #2 OUT1 = registers[1];
    //         3'b010: #2 OUT1 = registers[2];
    //         3'b011: #2 OUT1 = registers[3];
    //         3'b100: #2 OUT1 = registers[4];
    //         3'b101: #2 OUT1 = registers[5];
    //         3'b110: #2 OUT1 = registers[6];
    //         3'b111: #2 OUT1 = registers[7];

    //         default:  #2 OUT1 = 0;

    //     endcase

    // end

    assign #2 OUT1 = registers[OUT1ADDRESS];

    always @(OUT2ADDRESS, registers[0],registers[1],registers[2],registers[3],registers[4],registers[5],registers[6],registers[7]) begin
        
        case(OUT2ADDRESS)

            3'b000: #2 OUT2 = registers[0];
            3'b001: #2 OUT2 = registers[1];
            3'b010: #2 OUT2 = registers[2];
            3'b011: #2 OUT2 = registers[3];
            3'b100: #2 OUT2 = registers[4];
            3'b101: #2 OUT2 = registers[5];
            3'b110: #2 OUT2 = registers[6];
            3'b111: #2 OUT2 = registers[7];

            default:  #2 OUT2 = 0;

        endcase

    end

    always @(posedge CLK) begin
        
        if (WRITE && ~RESET) begin
        case(INADDRESS)

            3'b000: #1 registers[0] = IN;
            3'b001: #1 registers[1] = IN;
            3'b010: #1 registers[2] = IN;
            3'b011: #1 registers[3] = IN;
            3'b100: #1 registers[4] = IN;
            3'b101: #1 registers[5] = IN;
            3'b110: #1 registers[6] = IN;
            3'b111: #1 registers[7] = IN;
            
            default #1 registers[0] = 0;

        endcase
        end

        if (RESET) begin
            registers[0] = 0;
            registers[1] = 0;
            registers[2] = 0;
            registers[3] = 0;
            registers[4] = 0;
            registers[5] = 0;
            registers[6] = 0;
            registers[7] = 0;
        end

    end

    // always @(OUT1ADDRESS, OUT2ADDRESS, register0, register1, register2, register3, register4, register5, register6, register7) begin
        
    //     case(OUT1ADDRESS)

    //         3'b000: #2 OUT1 = register0;
    //         3'b001: #2 OUT1 = register1;
    //         3'b010: #2 OUT1 = register2;
    //         3'b011: #2 OUT1 = register3;
    //         3'b100: #2 OUT1 = register4;
    //         3'b101: #2 OUT1 = register5;
    //         3'b110: #2 OUT1 = register6;
    //         3'b111: #2 OUT1 = register7;

    //         default:  #2 OUT1 = 0;

    //     endcase

    //     case(OUT2ADDRESS)

    //         3'b000: #2 OUT2 = register0;
    //         3'b001: #2 OUT2 = register1;
    //         3'b010: #2 OUT2 = register2;
    //         3'b011: #2 OUT2 = register3;
    //         3'b100: #2 OUT2 = register4;
    //         3'b101: #2 OUT2 = register5;
    //         3'b110: #2 OUT2 = register6;
    //         3'b111: #2 OUT2 = register7;

    //         default:  #2 OUT2 = 0;

    //     endcase

    // end

    // reg [7:0][7:0] registers;

    // assign #1 OUT1 = registers[0][7:0];
    // assign #1 OUT2 = registers[1][7:0];

    // always @(posedge CLK) begin
        
    //     if (WRITE) #2 registers[0][7:0] = IN;

    //     if (RESET) registers[7:0][7:0] = 0;

    // end

endmodule