`timescale 1ns / 1ps
/*
Name: Akshar Patel
R-Number: R11694765
Assignment: Project 6
*/
module pc(
    input clk,
    input [48:0] literal, //instruction
    input Zflag, //input z flag
    output reg [5:0] PC = 0
    );

    //counter for delaying the cpu
    reg [3:0] counter = 0; 
    parameter BZ = 5'h10;
    parameter BNZ = 5'h11;
    parameter BRA = 5'h12;
    reg Z_temp = 0; //temp used for seeing previous z flag

    always @(posedge clk) begin
        if(counter < 2 ) begin
            if(counter == 1)begin 
                //delayed z flag set
                Z_temp <= Zflag;
            end
            counter <= counter + 1; 
        end else begin
            //case statement for branches based on z flag if needed
            case (literal[48:44])
                BZ: PC <= Z_temp ? literal[5:0] : PC + 1;
                BNZ: PC <= Z_temp ? PC + 1 : literal[5:0];
                BRA: PC <= literal[5:0];
                default: PC <= PC + 1;
            endcase
            //reset counter
            counter <= 0;
        end    
    end

endmodule
