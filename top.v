`timescale 1ns / 1ps

/*
Name: Akshar Patel
R-Number: R11694765
Assignment: Project 6
*/

module top(
    input clk, //clock input
    output [5:0] PC,
    output [48:0] inst
    );


    //different wires used for linking different files
    wire [4:0] opcode;
    wire [31:0] destination, source1;
    wire Zflag, load, ramread, regread, Z_temp;
    
    wire [31:0] literal;
    wire [31:0] literal_src;
    wire [31:0] lit_reg;
    
    wire [31:0] src1_reg;
    wire [31:0] src1_lit;
    wire [31:0] src1_ram;
    wire [1:0] mode;
    wire [5:0] pcount;
    wire [31:0] alu_out;
    wire [31:0] ram_location;
    wire [31:0] lit_switch;
    wire [31:0] src_switch;
    wire [31:0] src_depend;
    
    wire [48:0] instruction;


    //initializing rom and fetching instruction
    ROM U1(clk, PC, instruction);
    //changing pc
    pc P1(clk, instruction, Zflag, pcount);
    //decoding instruction
    decoder D1(instruction, clk, literal, destination,opcode,source1,mode, load, ramread, regread);
    //fetching data from register and writing from alu output
    register  R1( .AA(source1), .A(src1_reg), .BA(literal[4:0]), .B(lit_reg), .D(alu_out), .DA(destination), .RL(~load));
    //checking flag to see what the address for the ram we are using is
    assign ram_location = ramread ? source1 : destination;
    //getting data from ram 
    RAM RA1( clk, load, ram_location, src1_reg, src1_ram);
    
    //setting the source and lit based on the mode and flags from decoder
    assign src1_lit = (mode[1]) ? src1_reg : src1_ram;
    assign literal_src = (mode[1]) ? lit_reg : literal;
    assign lit_switch = ramread ? src1_lit : literal_src;
    assign src_switch = load ? src1_reg : src1_lit;
    assign src_depend = regread ? src1_reg : src_switch;

    //sending data into the ALU
    alu A1( src_depend, lit_switch, clk, opcode, Zflag,alu_out, Zflag);
    
    assign PC = pcount;
    assign inst = instruction;
endmodule
