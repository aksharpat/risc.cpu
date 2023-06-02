`timescale 1ns / 1ps
/*
Name: Akshar Patel
R-Number: R11694765
Assignment: Project 6
*/
module decoder(
    input [48:0] instr, //input instruction
    input clk, // clock input

    //outputs
    output reg [31:0] literal_src, dst,
    output reg [4:0] op,
    output [31:0] src1,
    output reg [1:0] md,
    output reg load,
    output ramload, regread
    );

    //flags for ram and reg
    reg flag1 = 0;
    reg regreadR = 0;
    reg [31:0] source;
    wire [31:0] source_temp;
    wire load_temp;
    always @(*) begin
        if(instr[48:44] == 5'h02) begin //ST 
            op <= instr[48:44];
            md <= instr[43:42];
            source <= instr[41:37];
            dst <= instr[31:0]; //flipped
            literal_src <= instr[36:32]; //flipped
            flag1 <= 0;
            load <= 1;
            regreadR <= 0;
        end else if(instr[48:44] == 5'h01 && md == 2'b01) begin //LD and direct
            op <= instr[48:44];
            md <= instr[43:42];
            source <= instr[31:0]; //flipped
            dst <= instr[36:32];
            literal_src <= instr[41:37];//flipped
            flag1 <= 1;
            load <= 0;
            regreadR <= 0;
        end else begin //everything else 
            op <= instr[48:44];
            md <= instr[43:42];
            source <= instr[41:37];
            dst <= instr[36:32];
            literal_src <= instr[31:0];
            flag1 <= 0;
            load <= 0;
            regreadR <= 1;
        end
    end
    assign load_temp = load;
    assign ramload = flag1;
    assign regread = regreadR;
    assign src1 = source;

endmodule
