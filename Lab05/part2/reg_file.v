// CO224 - Lab05 PART-1
// GROUP - 11

// REGISTER FILE module
// 8x8 register file that can store 8-bit binary numbers
// register numbers are 0-7
// INPUT ports: 
//     INADDRESS, OUT1ADDRESS, OUT2ADDRESS : 3-bit
//     IN : 8-bit
//     WRITE, CLK, RESET : 1-bit
// OUTPUT ports:
//     OUT1, OUT2 : 8-bit
// Reading  - for given register numbers(OUT1ADDRESS, OUT2ADDRESS), 
//            OUT1 and OUT2 will output the stored value asynchronously
//            reading delay - 2 time unit
// Writting - to a given register numbers(INADDRESS),
//            IN data will write synchronously when a positive clk edge and WRITE is enable
//            writting delay - 1 time unit
// Reset    - when reset is enable, all the register values will reset to 0 in a positive clk edge
module reg_file(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET);

    // declare input ports
    input [7:0] IN; // data in
    input [2:0]  INADDRESS, OUT1ADDRESS, OUT2ADDRESS;   // register numbers 
    input  WRITE, CLK, RESET;   // control signals

    // declare output ports
    output [7:0] OUT1, OUT2;    // data out
    
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
            // writting takes 1 time unit time
            #1 registers[INADDRESS] = IN;

        end

        // if RESET is enable
        // set all the register values to 0
        if (RESET) begin        
            
            // loop through all the registers
            for (integer i=0; i<8; i=i+1) begin
                registers[i] = 0;   // assign 0 to the registers
            end

        end

    end

endmodule