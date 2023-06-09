`timescale 1ns / 1ps
/*
Name: Akshar Patel
R-Number: R11694765
Assignment: Project 6
*/
module top_tb();

    reg clk = 0;
    wire[5:0] PC;
    wire [48:0] inst;
    
    top UUT(.clk(clk), .PC(PC), .inst(inst));
    

//start:
//        ld      r1, #$ABCDEF12
//        st      r1, $10
//        ld      r29, $10
//        ld      r6, #$8
//        ld      r7, #$9
//        ld      r20, #2
//loop:
//        sub     r21, r20, #1
//        add     r20, r21, #0
//        bnz     #loop
//        add     r31, r6, r7
//        add     r2, r31, #1
//        add     r3, r31, r2
//        add     r4, r3, #1
//        sub     r5, r4, #1
//        add     r30, r29, #1


  always begin
        clk <= ~clk;
        #5;
    end

endmodule
