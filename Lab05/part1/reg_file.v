module reg_file(IN,OUT1,OUT2,INADDRESS,OUT1ADDRESS,OUT2ADDRESS, WRITE, CLK, RESET);

    input [7:0] IN;
    input [2:0]  INADDRESS, OUT1ADDRESS, OUT2ADDRESS;
    input  WRITE, CLK, RESET;

    output [7:0] OUT1, OUT2;
    reg [7:0] OUT1, OUT2;

    reg [7:0] register0, register1, register2, register3, register4, register5, register6, register7;

    always @(OUT1ADDRESS, register0, register1, register2, register3, register4, register5, register6, register7) begin
        
        case(OUT1ADDRESS)

            3'b000: #2 OUT1 = register0;
            3'b001: #2 OUT1 = register1;
            3'b010: #2 OUT1 = register2;
            3'b011: #2 OUT1 = register3;
            3'b100: #2 OUT1 = register4;
            3'b101: #2 OUT1 = register5;
            3'b110: #2 OUT1 = register6;
            3'b111: #2 OUT1 = register7;

            default:  #2 OUT1 = 0;

        endcase

    end

    always @(OUT2ADDRESS, register0, register1, register2, register3, register4, register5, register6, register7) begin
        
        case(OUT2ADDRESS)

            3'b000: #2 OUT2 = register0;
            3'b001: #2 OUT2 = register1;
            3'b010: #2 OUT2 = register2;
            3'b011: #2 OUT2 = register3;
            3'b100: #2 OUT2 = register4;
            3'b101: #2 OUT2 = register5;
            3'b110: #2 OUT2 = register6;
            3'b111: #2 OUT2 = register7;

            default:  #2 OUT2 = 0;

        endcase

    end

    always @(posedge CLK) begin
        
        if (WRITE && ~RESET) begin
        case(INADDRESS)

            3'b000: #1 register0 = IN;
            3'b001: #1 register1 = IN;
            3'b010: #1 register2 = IN;
            3'b011: #1 register3 = IN;
            3'b100: #1 register4 = IN;
            3'b101: #1 register5 = IN;
            3'b110: #1 register6 = IN;
            3'b111: #1 register7 = IN;
            
            default #1 register0 = 0;

        endcase
        end

        if (RESET) begin
            register0 = 0;
            register1 = 0;
            register2 = 0;
            register3 = 0;
            register4 = 0;
            register5 = 0;
            register6 = 0;
            register7 = 0;
        end

    end

endmodule