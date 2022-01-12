`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.12.2021 11:38:23
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


module main(
    input clk,
    input rst,
    input mode1,
    input mode2,
    input mode3,
    input coin,
    output idle,
    output ready,
    output soak,
    output wash,
    output rinse,
    output spin,
    output Error,
    output coin_rtrn
    );
    wire min,mode,clk190,clk1,mode1d,mode2d,mode3d,soaked,washed,rinsed,spun,coind,cancel,ready1,ready2,ready3;
    assign min=mode1||mode2||mode3;
    clkdiv c1(clk,rst,clk190);
    debounce c2(clk190,min,rst,mode);
    debounce c3(clk190,mode1,rst,mode1d);
    debounce c4(clk190,mode2,rst,mode2d);
    debounce c5(clk190,mode3,rst,mode3d);
    debounce c9(clk190,coin,rst,coind);

    timer c6(clk190,idle,ready1,ready2,ready3,soak,wash,rinse,spin,soaked,washed,rinsed,spun);
    machine c7(clk190,rst,coind,soaked,washed,rinsed,spun,mode1d,mode2d,mode3d,cancel,idle,ready1,ready2,ready3,soak,wash,rinse,spin,Error,coin_rtrn);
    vio_0 c8(clk, cancel);
    assign ready=ready1||ready2||ready3;
endmodule
