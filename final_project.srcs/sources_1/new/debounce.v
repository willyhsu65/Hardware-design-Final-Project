`timescale 1ns/1ps

module Debounce(button, clk, button_debounced);
output button_debounced;
input button;
input clk; 

reg [3:0] DFF;
always @(posedge clk) 
begin
    DFF[3:1] <= DFF[2:0];
    DFF[0] <= button;
end
assign button_debounced = ((DFF == 4'b1111) ? 1'b1 : 1'b0);
endmodule