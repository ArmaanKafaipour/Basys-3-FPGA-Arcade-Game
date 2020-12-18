`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Armaan Kafaipour
// 
// Create Date: 11/04/2020 04:11:13 PM
// Design Name: 
// Module Name: ledController
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


module ledController(
    input clk,
    input btnU,
    input btnC,
    input btnD,
    input sw,
    output reg [15:0] led,
    output reg [3:0] digitOne,
    output reg [3:0] digitTwo,
    output reg [3:0] digitThree,
    output reg [3:0] digitFour
    
    );
    parameter gameCounterInitial = 100_000_000;
    parameter buttonCounterInitial = 15_000_000;

    reg [31:0] currentLED = 0;
    reg [31:0] gameCounter = 0;
    reg [31:0] gameCounterMax = gameCounterInitial;// 100 MHz / 100_000_000 = 1 second clock 
    
    reg [31:0] buttonCounter = 0;
    
    reg [5:0] score = 0;
    reg [5:0] highScore = 0;
    
    //Button slow clock and button input logic to change score and alter clock speed
    always @(posedge clk) begin
            if(buttonCounter < buttonCounterInitial) begin
                buttonCounter <= buttonCounter + 1;
            end
            else begin
                buttonCounter <= 0;
                // Two rightmost digits get score
                digitOne <= score % 10;
                digitTwo <= score / 10;
                // Two leftmost digits get high score
                digitThree <= highScore % 10;
                digitFour <= highScore / 10;      
                if(btnC) begin
                    // IF button is pressed while led 7 is active
                    if(led[7] == 1) begin
                        score <= score + 1;   
                        if(sw) begin
                            // Hard mode if switch is flipped on
                            gameCounterMax <= gameCounterMax / 2;
                        end
                        if(!sw) begin
                            // Easy mode if switch is flipped off
                            gameCounterMax <= gameCounterMax - 8_500_000;
                        end
                        
                    end      
                    // Lose game is btnC is pressed while led 7 is not lit            
                    else begin               
                        score <= 0;
                        gameCounterMax <= gameCounterInitial;
                    end
                    // Assign score to high score 
                    if(score >= highScore) begin
                            highScore <= score;      
                        end       
                end
                // Soft Reset - reset score and clock speed and save score to high score with Up button press
                if(btnU) begin
                    score <= 0;
                    gameCounterMax <= gameCounterInitial;
                    if(score >= highScore) begin
                            highScore <= score;      
                        end
                end
                // Hard reset - reset score and high score to 0, reset clock speed to initial speed
                if(btnD) begin
                    score <= 0;
                    highScore <= 0;
                    gameCounterMax <= gameCounterInitial;
                end

            end
        end
    
     // LED CLOCK LOGIC
    always @(posedge clk) begin
        if(btnU || btnD) begin
            led = 0;
            currentLED <= 1;
        end
        if (gameCounter < gameCounterMax) begin
            gameCounter <= gameCounter + 1;
        end
        else begin
            currentLED <= currentLED + 1;
            gameCounter <= 0;
        end        
        
        case (currentLED) 
            1: 
                led[0] = 1;
            2: begin
                led[0] = 0;
                led[1] = 1;
            end
            3: begin
                led[1] = 0;
                led[2] = 1;
            end
            4: begin
                led[2] = 0;
                led[3] = 1;
            end    
            5: begin
                led[3] = 0;
                led[4] = 1;
            end    
            6: begin
                led[4] = 0;
                led[5] = 1;
            end
            7: begin
                led[5] = 0;
                led[6] = 1;
            end
            8: begin
                led[6] = 0;
                led[7] = 1;
            end
            9: begin
                led[7] = 0;
                led[8] = 1;
            end
            10: begin
                led[8] = 0;
                led[9] = 1;
            end
            11: begin
                led[9] = 0;
                led[10] = 1;
            end
            12: begin
                led[10] = 0;
                led[11] = 1;
            end
            13: begin
                led[11] = 0;
                led[12] = 1;
            end
            14: begin
                led[12] = 0;
                led[13] = 1;
            end
            15: begin
                led[13] = 0;
                led[14] = 1;
            end
            16: begin
                led[14] = 0;
                led[15] = 1;
            end
            17: begin
                led[15] = 0;
                led[14] = 1;
            end
            18: begin
                led[14] = 0;
                led[13] = 1;
            end
            19: begin
                led[13] = 0;
                led[12] = 1;
            end
            20: begin
                led[12] = 0;
                led[11] = 1;
            end
            21: begin
                led[11] = 0;
                led[10] = 1;
            end
            22: begin
                led[10] = 0;
                led[9] = 1;
            end
            23: begin
                led[9] = 0;
                led[8] = 1;
            end
            24: begin
                led[8] = 0;
                led[7] = 1;
            end
            25: begin
                led[7] = 0;
                led[6] = 1;
            end
            26: begin
                led[6] = 0;
                led[5] = 1;
            end
            27: begin
                led[5] = 0;
                led[4] = 1;
            end
            28: begin
                led[4] = 0;
                led[3] = 1;
            end
            29: begin
                led[3] = 0;
                led[2] = 1;
            end
            30: begin
                led[2] = 0;
                led[1] = 1;
            end
            31: begin
                led[1] = 0;
                currentLED <= 1;
            end
            
            

         endcase
    end
    
endmodule
