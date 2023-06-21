/*
Module  : Data Cache 
Author  : Isuru Nawinne, Kisaru Liyanage
Date    : 25/05/2020

Description	: Group - 11

*/
`timescale 1ns/100ps

module icache (
    clock,
    reset,
    busywait,
    readdata,
    address,
    mem_busywait,
    mem_read,
    mem_readdata,
    mem_address
);

    // declare ports for input and output
    input mem_busywait, clock, reset;
    input [9:0] address;
    input [127:0] mem_readdata;
    output reg mem_read, busywait; 
    output reg [31:0] readdata;
    output reg [5:0] mem_address;

    // cashe files
    reg [131:0] cache [7:0];

    // registers for store intermediate values
    reg hit, valid;
    reg [31:0] dataword;
    reg [2:0] tag;
    wire [2:0] index;
    reg [131:0] cache_entry;

    // get the index value
    assign index = address[6:4];

    // use a trigger
    reg flag;

    // indexing base on index
    always @(address) begin
        flag = 0;
    end
    

    // indexing base on index
    always @(address, cache[index]) begin

        #0.00001
        #0.99999 cache_entry = cache[index];
        flag = 1;

    end

    // Tag comparison and validation 
    // check whether the access is a hit or miss
    always @(cache_entry, posedge flag) begin

        // delay for Tag comparison and validation 
        #0.9
        // getting the valid, dirty bits and tag
        valid = cache_entry[131];
        tag = cache_entry[130:128];

        // check the block is valid and tags are matching
        // if there are a read validation and tag comparison can detemine a hit
        if (valid && tag == address[9:7])
            hit = 1'b1;
        // else miss
        else 
            hit = 1'b0;

    end

    // data word selection
    always @(cache_entry, posedge flag) begin

        // delay for selecting the data word 
        #1
        // getting the dataword from the data block
        case(address[3:2])
            2'b00: dataword = cache_entry[31:0];
            2'b01: dataword = cache_entry[63:32];
            2'b10: dataword = cache_entry[95:64];
            2'b11: dataword = cache_entry[127:96];
        endcase  

    end

    // in a read-hit
    always @(*) begin
        
        // check whether it is a hit and going to read from cache
        if (hit && !busywait)
            readdata = dataword;

    end

    // in a write-hit
    always @( negedge mem_busywait ) begin

        // when the reading from main mem is done
        // cache should write the read data from the main mem
        // the block should valid and not dirty

        // delay to writing the cashe
        #1 cache[index] = {1'b1, address[9:7], mem_readdata};

    end

    /* Cache Controller FSM Start */

    parameter IDLE = 3'b000, MEM_READ = 3'b001;
    reg [2:0] state, next_state;

    // combinational next state logic
    always @(*)
    begin
        #0.00001
        case (state)
            IDLE:
                if (!hit) begin 
                    next_state = MEM_READ;
                    // busywait = 1;
                end
                else begin
                    next_state = IDLE;
                    // busywait = 0;
                end
            MEM_READ:
                if (!mem_busywait)begin
                    next_state = IDLE;
                    // busywait = 0;
                end
                else    begin
                    next_state = MEM_READ;
                    // busywait = 1;
                end
            
        endcase
    end

    // combinational output logic
    always @(*)
    begin
        case(state)
            IDLE:
            begin
                mem_read = 0;
                mem_address = 5'dx;
                busywait = 0;
            end
         
            MEM_READ: 
            begin
                mem_read = 1;
                mem_address = {address[9:7], index};
                busywait = 1;
            end
            
        endcase
    end

    // sequential logic for state transitioning 
    always @(posedge clock, reset)
    begin
        if(reset)
            state = IDLE;
        else
            state = next_state;
    end

    /* Cache Controller FSM End */

    //Reset cache memory
    always @(posedge reset)
    begin
        if (reset)
        begin
            for (integer i=0;i<8; i=i+1)
                cache[i] = 0;
            
            busywait = 0;
        end
    end

endmodule