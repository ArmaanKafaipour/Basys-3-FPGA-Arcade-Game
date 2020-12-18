`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Armaan Kafaipour
// 
// Create Date: 11/04/2020 03:12:01 PM
// Design Name: San Diego State University
// Module Name: bcd7segment
// Project Name: COMPE 470L Final Project
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bcd7segment(
    input clk,
    input [3:0] digitOne,
    input [3:0] digitTwo,
    input [3:0] digitThree,
    input [4:0] digitFour,
    output reg [6:0] seg,
    output reg [3:0] an
    );
    
    reg [1:0] currentDigit = 0;  // Keeps track of digits 1-4
    reg [6:0] segment [3:0];     
    
    reg [18:0] digitCounter = 0; // Variable that counts to 500,000
    parameter digitCounterMax = 500000; // 100 MHz / 500,000 = 5ms clock
    
    wire [3:0] fourDigits [3:0];   //2D array to store the values of the 4 digits, populated below
    assign fourDigits[0] = digitOne;
    assign fourDigits[1] = digitTwo;

    assign fourDigits[2] = digitThree;
    assign fourDigits[3] = digitFour;
                      	 
    always @(posedge clk) begin
        if (digitCounter < digitCounterMax) begin
            digitCounter <= digitCounter+1;
        end 
        else begin
            currentDigit <= currentDigit + 1; // switch digits every 5 ms
            digitCounter <= 0;
        end 
    
        case(fourDigits[currentDigit])
            4'b0000: segment[currentDigit] = 7'b100_0000; // "0"     
            4'b0001: segment[currentDigit] = 7'b111_1001; // "1" 
            4'b0010: segment[currentDigit] = 7'b010_0100; // "2" 
            4'b0011: segment[currentDigit] = 7'b011_0000; // "3" 
            4'b0100: segment[currentDigit] = 7'b001_1001; // "4" 
            4'b0101: segment[currentDigit] = 7'b001_0010; // "5" 
            4'b0110: segment[currentDigit] = 7'b000_0010; // "6" 
            4'b0111: segment[currentDigit] = 7'b111_1000; // "7" 
            4'b1000: segment[currentDigit] = 7'b000_0000; // "8"     
            4'b1001: segment[currentDigit] = 7'b001_0000; // "9"        
            default: segment[currentDigit] = 7'b100_0000; // "0"
        endcase
        
        case(currentDigit)
            0: begin
                an <= 4'b1110;
                seg <= segment[0];      
            end 
            1: begin
                an <= 4'b1101;
                seg <= segment[1];            
            end
             2: begin
                an <= 4'b1011;
                seg <= segment[2];
            end
            
            3: begin
                an <= 4'b0111;
                seg <= segment[3];
            end                
        endcase
    end
    
endmodule
