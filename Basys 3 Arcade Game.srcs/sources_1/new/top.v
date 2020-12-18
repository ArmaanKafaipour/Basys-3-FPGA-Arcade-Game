`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Armaan Kafaipour
// 
// Create Date: 11/04/2020 01:22:19 PM
// Design Name: 
// Module Name: main
// Project Name: 
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


module main 
  ( input clk,
    input btnC,
    input btnU,
    input btnD,
    input sw,
    output [15:0] led,
    output [6:0] seg,
    output [3:0] an
    );
    
    wire [3:0] digitOne, 
               digitTwo, 
               digitThree, 
               digitFour;
    
    // Instantiate the display driver
    bcd7segment b1(  .clk(clk), 
                     .digitOne(digitOne),
                     .digitTwo(digitTwo), 
                     .digitThree(digitThree), 
                     .digitFour(digitFour),
                     .seg(seg),
                     .an(an) ); 
    
    // Instantiate the LED clock logic and controller
    ledController led1( .clk(clk), 
                        .btnC(btnC),    
                        .btnU(btnU), 
                        .btnD(btnD),
                        .sw(sw),
                        .led(led), 
                        .digitOne(digitOne), 
                        .digitTwo(digitTwo), 
                        .digitThree(digitThree), 
                        .digitFour(digitFour) );
                        
   
endmodule
