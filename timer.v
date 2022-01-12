`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2021 12:29:33
// Design Name: 
// Module Name: timer
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


module timer(
    input clk,
    input idle,
    input ready1,
    input ready2,
    input ready3,
    input soak,
    input wash,
    input rinse,
    input spin,
    output reg soaked,
    output reg washed,
    output reg rinsed,
    output reg spun
    );
    parameter wash1time=500,wash2time=750,wash3time=1000,soaktime=800,rinsetime=900,spintime=1000;
    reg [9:0] washcounter,soakcounter,rinsecounter,spincounter,washtime;
    
    always@(posedge clk)
    begin 
        if(ready1==1) washtime=wash1time;
        else if(ready2==1) washtime=wash2time;
        else if(ready3==1) washtime=wash3time;
    end
    
    always@(posedge clk)
    begin
        if(soakcounter==soaktime)soaked=1;
        if(washcounter==washtime) washed=1;
        if(rinsecounter==rinsetime) rinsed=1;
        if(spincounter==spintime) spun=1;
        
        if(idle==1 || ready1==1 || ready2==1 || ready3==1) begin
            washcounter=0;
            soakcounter=0;
            rinsecounter=0;
            spincounter=0;
            soaked=0;
            washed=0;
            rinsed=0;
            spun=0;
        end
        
        if(soak==1) soakcounter=soakcounter+1;
        if(wash==1) washcounter=washcounter+1;
        if(rinse==1) rinsecounter=rinsecounter+1;
        if(spin==1) spincounter=spincounter+1;
    end
    
endmodule
