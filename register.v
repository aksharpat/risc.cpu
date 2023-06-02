`timescale 1ns / 1ps
/*
Name: Akshar Patel
R-Number: R11694765
Assignment: Project 6
*/
module register(
    input [31:0] D, //input data
    input [4:0] DA, //data address line
    input [4:0] BA, //output b address line
    input [4:0] AA, //output a address line
    input RL, //register load
    input clk, //clock
    output [31:0] A, 
    output [31:0] B
    );

    
    reg [31:0] mem [31:0]; //32x32 register
    //always have the outputs equal to their corresponding registers
    assign A = mem[AA];
    assign B = mem[BA]; 

    always @(*)begin 
    //whenever Register Load is used, set the value for the register
        if(RL) begin
            mem[DA] <= D;
        end
    end

endmodule
