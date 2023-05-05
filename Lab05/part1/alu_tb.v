`include "alu.v"

module alu_tb;

    reg [7:0] DATA1, DATA2;
    reg [2:0] SELECT;
    wire [7:0] RESULT;


    alu ALU(DATA1, DATA2, RESULT, SELECT);

    initial begin
        $monitor($time, " %d - %d  %d = %d",SELECT, DATA1, DATA2, RESULT);
    end

    initial begin
        DATA1 = 0;
        DATA2 = 0;
        SELECT = 0;

        #5 DATA1 = 5; DATA2 = 5;
        #5 DATA2 = 0;
        #5 DATA2 = 1;


        #5 SELECT = 1;
        

        #5 DATA1 = 5; DATA2 = 5;
        #5 DATA2 = 4;
        #5 DATA1 = 8;

    end



endmodule