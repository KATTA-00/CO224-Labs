`include "test.v"

module tb;

    reg [7:0] DATA1, DATA2;
    reg [2:0] SELECT;
    wire [7:0] RESULT;

    alu ALU(DATA1, DATA2, RESULT, SELECT);

    initial begin
        DATA1 = 0;
        DATA2 = 0;
        SELECT = 0;

        #5 DATA1 = 5;
        #5 DATA2 = 5;
        #5 DATA2 = 0;
        #5 DATA2 = 1;

    end

    initial begin
        $monitor($time, " %d - %d  %d = %d",SELECT, DATA1, DATA2, RESULT);
    end




endmodule