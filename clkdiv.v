`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2021 12:38:55
// Design Name: 
// Module Name: clkdiv
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


module clkdiv(
    input mclk,
    input rst,
    output clk190
);
reg [18:0] clk_div;
always@(posedge mclk,posedge rst)
begin
if(rst==1)
clk_div=0;
else 
clk_div=clk_div+1; 
end

assign clk190=clk_div[18];
endmodule
