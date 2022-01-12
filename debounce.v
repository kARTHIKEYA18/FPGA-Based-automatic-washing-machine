`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2021 11:57:13
// Design Name: 
// Module Name: debounce
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


module debounce(
    input clk190,
    input din,
    input rst,
    output dout
    );
    reg a,b,c;
    
    always@(posedge clk190,posedge rst)
    begin
    if(rst==1)
    begin
    a<=0;
    b<=0;
    c<=0;
    end
    else
    a<=din;
    b<=a;
    c<=b;
    end
    
    assign dout= a&b& ~c;
endmodule
