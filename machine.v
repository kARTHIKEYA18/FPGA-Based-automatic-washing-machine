`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2021 11:15:14
// Design Name: 
// Module Name: machine
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


module machine(
    input clk,
    input rst,
    input coin,
    input soaked,
    input washed,
    input rinsed,
    input spun,
    input mode1,
    input mode2,
    input mode3,
    input cancel,
    output reg idle,
    output reg ready1,
    output reg ready2,
    output reg ready3,
    output reg soak,
    output reg wash,
    output reg rinse,
    output reg spin,
    output reg Error,
    output reg coin_rtrn
    );
    reg [4:0] present_state,next_state;
parameter IDLE = 'd0,
          READY1='d1,
          READY2='d2,
          READY3='d3,
          SOAK='d4,
          WASH='d5,
          RINSE='d6,
          SPIN='d7,
          COIN='d8,
          ERROR='d9;
          
        
    //state reg
    always@(posedge clk,posedge rst)
    begin
    if(rst==1) present_state=IDLE;
    else present_state=next_state;
    end
    
    //input part
    always@(*)
    begin
    case(present_state)
    IDLE:
        begin 
        if(coin==1) next_state=READY1;
        else next_state=IDLE;
        end
    
    READY1:
        begin
        if(cancel==1)
        begin next_state=COIN;  end
        else if(coin==1) next_state=READY2;
        else if((mode1==1))
        next_state=SOAK;
        else if(mode2==1 || mode3==1) next_state=ERROR;
        else next_state=READY1;
        end
    
    READY2:
        begin
        if(cancel==1)
        begin next_state=COIN;  end
        else if(coin==1) next_state=READY3;
        else if((mode2==1)) next_state=SOAK;
        else if(mode1==1 || mode3==1) next_state=ERROR;
        else next_state=READY2;
        end
        
     READY3:
            begin
            if(cancel==1)
            begin next_state=COIN;  end       
            else if(coin==1) next_state=READY3;
            else if((mode3==1)) next_state=SOAK;
            else if(mode2==1 || mode1==1) next_state=ERROR;
            else next_state=READY3;
            end
    SOAK:
        begin
        if(cancel==1)
        next_state=IDLE;
        else if(soaked==1)
        next_state=WASH;
        else next_state=SOAK;
    end
    
    WASH:
        begin
        if(cancel==1)
        next_state=IDLE;
        else if(washed==1 )
        next_state=RINSE;
        else next_state=WASH;
    end
    
    RINSE:
        begin
        if(cancel==1)
        next_state=IDLE;
        else if(rinsed==1)
        next_state=SPIN;
        else next_state=RINSE;
    end
    
    SPIN:
    begin
        if(cancel==1)
        next_state=IDLE;
        else if(spun==1)
        next_state=IDLE;
        else next_state=SPIN;
        end
    ERROR:
    next_state=ERROR;
    COIN: next_state=COIN;
    endcase
    end
    
    //output part
    always@(present_state)
    begin
    case(present_state)
    IDLE: begin idle=1;ready1=0;ready2=0;ready3=0;soak=0;wash=0;rinse=0;spin=0; Error=0;coin_rtrn=0; end
    READY1:begin idle=0;ready1=1;ready2=0;ready3=0;soak=0;wash=0;rinse=0;spin=0; Error=0;coin_rtrn=0; end
    READY2:begin idle=0;ready1=0;ready2=1;ready3=0;soak=0;wash=0;rinse=0;spin=0; Error=0; coin_rtrn=0;end
    READY3:begin idle=0;ready1=0;ready2=0;ready3=1;soak=0;wash=0;rinse=0;spin=0; Error=0; coin_rtrn=0;end
    SOAK:begin idle=0;ready1=0;ready2=0;ready3=0;soak=1;wash=0;rinse=0;spin=0; Error=0;coin_rtrn=0; end
    WASH: begin idle=0;ready1=0;ready2=0;ready3=0;soak=0;wash=1;rinse=0;spin=0; Error=0;coin_rtrn=0; end
    RINSE: begin idle=0;ready1=0;ready2=0;ready3=0;soak=0;wash=0;rinse=1;spin=0; Error=0; coin_rtrn=0;end
    SPIN: begin idle=0;ready1=0;ready2=0;ready3=0;soak=0;wash=0;rinse=0;spin=1; Error=0; coin_rtrn=0;end
    ERROR: begin idle=0;ready1=0;ready2=0;ready3=0;soak=0;wash=0;rinse=0;spin=0; Error=1; coin_rtrn=0;end
    COIN: begin idle=0;ready1=0;ready2=0;ready3=0;soak=0;wash=0;rinse=0;spin=0; Error=0;coin_rtrn=1; end
    
    endcase
    end
endmodule
