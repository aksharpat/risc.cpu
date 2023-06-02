`timescale 1ns / 1ps
/*
Name: Akshar Patel
R-Number: R11694765
Assignment: Project 6
*/
module alu(
    input [31:0] A, //BOTH 32 BIT INPUTS
    input [31:0] B, 
    input clk, //CLOCK
    input [4:0] opcode, //OPCODE FOR SELECTION
    input Zin, 
    output reg [31:0] ALUout,  //OUTPUT
    output reg Zflag//FLAGS
    );

always @(*) begin
    case(opcode)
        5'b00001: begin // LOAD REGISTER B
            ALUout = B;
            Zflag = (ALUout == 0); //ZflagERO CHECK

        end
        5'b00010: begin // store REGISTER B
            ALUout = A;
            Zflag = (ALUout == 0); //ZflagERO CHECK

        end
        5'b00011: begin // ADD A AND B
            ALUout = A + B;
            Zflag= (ALUout == 0);//ZERO CHECK
            
        end
        5'b00100: begin // SUB A AND B
            ALUout = A - B;
            Zflag= (ALUout == 0);//ZERO CHECK

        end
        5'b00101: begin // AND A AND B
            ALUout = A & B;
            Zflag= (ALUout == 0);//ZERO CHECK

        end
        5'b00110: begin // OR A AND B
            ALUout = A | B;
            Zflag= (ALUout == 0);//ZERO CHECK

        end
        5'b00111: begin // XOR A AND B
            ALUout = A ^ B;
            Zflag= (ALUout == 0);//ZERO CHECK

        end
        5'b01000: begin // NOT B
            ALUout = ~B;
            Zflag= (ALUout == 0);//ZERO CHECK

        end
        5'b01001: begin // SL A BY B
            ALUout = A << B[4:0];
            Zflag= (ALUout == 0);//ZERO CHECK

        end
        5'b01010: begin // SR A BY B
            ALUout = A >> B[4:0];
            Zflag= (ALUout == 0);//ZERO CHECK

        end
        default: begin //DEFAULT CASE
            ALUout = 32'b0;
            Zflag= 0;

        end
    endcase
end

endmodule
