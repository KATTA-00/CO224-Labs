/*
Module  : Data Cache 
Author  : Isuru Nawinne, Kisaru Liyanage
Date    : 25/05/2020

Description	: Group - 11

*/
`timescale 1ns/100ps

module dcache (
    clock,
    reset,
    busywait,
    read,
    write,
    writedata,
    readdata,
    address,
    mem_busywait,
    mem_read,
    mem_write,
    mem_writedata,
    mem_readdata,
    mem_address
);

    // declare ports for input and output
    input read, write, mem_busywait, clock, reset;
    input [7:0] writedata, address;
    input [31:0] mem_readdata;
    output reg mem_read, mem_write, busywait; 
    output reg [7:0] readdata;
    output reg [5:0] mem_address;
    output reg [31:0] mem_writedata;

    // cashe files for data
    reg [36:0] cache [7:0];

    // registers for store intermediate values
    reg dirty, hit, valid;
    reg [7:0] dataword;
    reg [2:0] tag;
    wire [1:0] index;
    reg [36:0] cache_entry;

    // get the index value
    assign index = address[4:2];

    // indexing base on index
    always @(address, cache[index]) begin
        // get the data block
        #1 cache_entry = cache[index];

    end

    // Tag comparison and validation 
    // check whether the access is a hit or miss
    always @(cache_entry, read, write, negedge clock) begin

        // delay for Tag comparison and validation 
        #0.9
        // getting the valid, dirty bits and tag
        valid = cache_entry[36];
        dirty = cache_entry[35];
        tag = cache_entry[34:32];

        // check the block is valid and tags are matching
        // if there are a read validation and tag comparison can detemine a hit
        if (read && valid && tag == address[7:5])
            hit = 1'b1;
        // if there are write validation, dirty and tag comparison can detemine a hit
        else if (write && valid && !dirty && tag == address[7:5])
            hit = 1'b1;
        // else miss
        else 
            hit = 1'b0;

    end

    // data word selection
    always @(cache_entry, read, write, negedge clock) begin

        // delay for selecting the data word 
        #1
        // getting the dataword from the data block
        case(address[1:0])
            2'b00: dataword = cache_entry[7:0];
            2'b01: dataword = cache_entry[15:8];
            2'b10: dataword = cache_entry[23:16];
            2'b11: dataword = cache_entry[31:24];
        endcase  

    end

    // in a read-hit
    always @(*) begin
        
        // check whether it is a hit and going to read from cache
        if (hit && read)
            readdata = dataword;

    end

    // in a write-hit
    always @(posedge clock) begin

        // write the cashe
        if(hit && write) begin
            // delay to writing the cashe
            #1
            // write the data to the cache
            case(address[1:0])
            2'b00: cache[index] = {1'b1, 1'b1,address[7:5], cache[index][31:8], writedata };
            2'b01: cache[index] = {1'b1, 1'b1,address[7:5], cache[index][31:16], writedata, cache[address[4:2]][7:0] };
            2'b10: cache[index] = {1'b1, 1'b1,address[7:5], cache[index][31:24], writedata , cache[address[4:2]][15:0]};
            2'b11: cache[index] = {1'b1, 1'b1,address[7:5], writedata, cache[index][23:0] };
            endcase 
        end 
        // when the reading from main mem is done
        // cache should write the read data from the main mem
        // the block should valid and not dirty
        else if(!mem_busywait && !hit && (read || write) && mem_read) begin
            // delay to writing the cashe
            #1 cache[index] = {1'b1, 1'b0, address[7:5], mem_readdata};
        // when the writting to the main mem is done
        // the dirty bit should be 0, since that block is written to the mem
        end else if(!mem_busywait && !hit && (read || write) && mem_write) begin
            cache[index][35] = 1'b0;
        end

    end

    /* Cache Controller FSM Start */

    parameter IDLE = 3'b000, MEM_READ = 3'b001, MEM_WRITE = 3'b010;
    reg [2:0] state, next_state;

    // combinational next state logic
    always @(*)
    begin
        case (state)
            IDLE:
                if ((read || write) && !dirty && !hit) begin 
                    next_state = MEM_READ;
                    // busywait = 1;
                end
                else if ((read || write) && dirty && !hit)begin
                    next_state = MEM_WRITE;
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

            MEM_WRITE:
                if (!mem_busywait)begin
                    next_state = IDLE;
                    // busywait = 0;
                end
                else    begin
                    next_state = MEM_WRITE;
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
                mem_write = 0;
                mem_address = 5'dx;
                mem_writedata = 32'dx;
                busywait = 0;
            end
         
            MEM_READ: 
            begin
                mem_read = 1;
                mem_write = 0;
                mem_address = {address[7:5], index};
                mem_writedata = 32'dx;
                busywait = 1;
            end

            MEM_WRITE: 
            begin
                mem_read = 0;
                mem_write = 1;
                mem_address = {tag, index};
                mem_writedata = cache_entry;
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