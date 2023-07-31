`include "test1.v"

module tb;

    reg [7:0] IN;
    reg [2:0]  INADDRESS, OUT1ADDRESS, OUT2ADDRESS;
    reg  WRITE, CLK, RESET;

    wire [7:0] OUT1, OUT2;

    reg_file file(IN,OUT1,OUT2,INADDRESS,OUT1ADDRESS,OUT2ADDRESS, WRITE, CLK, RESET);

    initial begin
        IN = 0; INADDRESS = 0; OUT1ADDRESS = 0; OUT2ADDRESS = 1; WRITE = 0; CLK = 0; RESET = 0;

        #3
        WRITE = 1;
        IN = 10;
        RESET = 0;

    end

    always
    #10 CLK = ~CLK;

    initial
    #50 $finish;

    initial begin
        $monitor($time, "%d | %d  %d | inA %d OutA %d %d | %d %d %d",IN,OUT1,OUT2,INADDRESS,OUT1ADDRESS,OUT2ADDRESS, WRITE, CLK, RESET);
    end




endmodule