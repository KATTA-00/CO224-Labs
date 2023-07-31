// CO224 - Lab05 PART-1
// GROUP - 11

// REGISTER FILE module
// 8x8 register file that can store 8-bit binary numbers
// register numbers are 0-7
// INPUT ports: 
//     INADDRESS, OUT1ADDRESS, OUT2ADDRESS, IN, WRITE, CLK, RESET
// OUTPUT ports:
//     OUT1, OUT2
// Reading - for given register numbers(OUT1ADDRESS, OUT2ADDRESS), 
//           OUT1 and OUT2 will output the stored value asynchronously
//           reading delay - 2 time unit
// Writting - to a given register numbers(INADDRESS),
//            IN data will write synchronously when a positive clk edge and WRITE is enable
//            writting delay - 1 time unit
// Reset - when reset is enable, all the register values will reset to 0 in a positive clk edge
module reg_file(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET);

    // declare input ports
    input [7:0] IN;
    input [2:0]  INADDRESS, OUT1ADDRESS, OUT2ADDRESS;
    input  WRITE, CLK, RESET;

    // declare output ports
    output [7:0] OUT1, OUT2;
    
    // declare the 8-bit, 8 registers
    reg [7:0] registers [7:0];

    // assign block for change the OUT1, in a change of OUT1ADDRESS or register values
    // with a 2 time unit delay
    assign #2 OUT1 = registers[OUT1ADDRESS];

    // assign block for chnage the OUT1, in a change of OUT2ADDRESS or register values
    // with a 2 time unit delay
    assign #2 OUT2 = registers[OUT2ADDRESS];

    // always block for check for a positive clk edge
    // to write a reg or reset registers
    always @(posedge CLK) begin
        
        // to write a register
        // WRITE should be enable and RESET should be desable
        if (WRITE && ~RESET) begin
            
            // select the appropriate reg numbers
            #1 registers[INADDRESS] = IN;
        end

        // if RESET is enable
        // set all the register values to 0
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

endmodule