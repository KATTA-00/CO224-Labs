// CO224 - Lab05 PART-3
// GROUP - 11

// Computer Architecture (CO224) - Lab 05
// Design: Testbench of Integrated CPU of Simple Processor
// Author: Isuru Nawinne

`timescale 1ns/100ps
`include "cpu.v"    
`include "dmem.v"
`include "dcache.v"
`include "imem.v"
`include "icache.v"


module cpu_tb;

    reg CLK, RESET;
    wire [31:0] PC;
    // wire [31:0] INSTRUCTION;
    wire [31:0] INSTRUCTION;
    
    // TODO: Initialize an array of registers (8x1024) named 'instr_mem' to be used as instruction memory
    // reg [7:0] instr_mem [1023:0];

    
    
    // // TODO: Create combinational logic to support CPU instruction fetching, given the Program Counter(PC) value 
    // //       (make sure you include the delay for instruction fetching here)

    // always @(PC) begin
    //     #2
    //     INSTRUCTION[31:24] = instr_mem[PC+3];
    //     INSTRUCTION[23:16] = instr_mem[PC+2];
    //     INSTRUCTION[15:8] = instr_mem[PC+1];
    //     INSTRUCTION[7:0] = instr_mem[PC];
    // end
    
    // initial
    // begin
    //     // Initialize instruction memory with the set of instructions you need execute on CPU
        
    //     // loading instr_mem content from instr_mem.mem file
    //     $readmemb("instr_mem.mem", instr_mem);

    // end

    // declare wires
    wire WRITE, READ, BUSYWAIT;
    wire [7:0] WRITEDATA, READDATA, ADDRESS;
    wire MEM_BUSYWAIT, MEM_READ, MEM_WRITE;
    wire [31:0] MEM_WRITEDATA, MEM_READATA;
    wire [5:0] MEM_ADDRESS;

    /* 
    ------------------------
     SIMPLE INSTRUCTION MEM
    ------------------------
    */
    wire IMEM_READ, IMEM_BUSYWAIT;
    wire [127:0] READINST;
    wire [5:0] IADDRESS;

    instruction_memory myinstruction_memory(CLK, IMEM_READ, IADDRESS, READINST, IMEM_BUSYWAIT);

    icache myicache(CLK, RESET, BUSYWAIT, INSTRUCTION, PC[9:0], IMEM_BUSYWAIT, IMEM_READ, READINST, IADDRESS);
    
    
    /* 
    -----
     CPU
    -----
    */
    cpu mycpu(PC, INSTRUCTION, CLK, RESET, WRITEDATA, READDATA, ADDRESS, WRITE, READ, BUSYWAIT);


    /* 
    -----
     DATA MEMORY
    -----
    */
    data_memory mydata_memory(CLK, RESET, MEM_READ, MEM_WRITE, MEM_ADDRESS, MEM_WRITEDATA, MEM_READATA, MEM_BUSYWAIT);
    /* 
    -----
     CASHE
    -----
    */
    dcache mydcashe(CLK, RESET, BUSYWAIT, READ, WRITE, WRITEDATA, READDATA, ADDRESS, MEM_BUSYWAIT, MEM_READ, MEM_WRITE, MEM_WRITEDATA, MEM_READATA, MEM_ADDRESS);

    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
		$dumpvars(3, cpu_tb,  cpu_tb.mycpu.Reg_File.registers[0], cpu_tb.mycpu.Reg_File.registers[1], cpu_tb.mycpu.Reg_File.registers[2], cpu_tb.mycpu.Reg_File.registers[3], cpu_tb.mycpu.Reg_File.registers[4], cpu_tb.mycpu.Reg_File.registers[5], cpu_tb.mycpu.Reg_File.registers[6], cpu_tb.mycpu.Reg_File.registers[7]);
        
        CLK = 1'b0;
        RESET = 1'b0;
        
        // TODO: Reset the CPU (by giving a pulse to RESET signal) to start the program execution
        RESET = 1'b1;
        #5
        RESET = 1'b0;
        
        // finish simulation after some time
        #4000
        $finish;
        
    end
    
    // clock signal generation
    always
    #4 CLK = ~CLK;

    initial begin
        $monitor($time, " %d %b", PC, INSTRUCTION);
    end
        

endmodule