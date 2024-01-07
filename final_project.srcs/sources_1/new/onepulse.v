`timescale 1ns/1ps

module OnePulse(PB_debounced, clk, PB_one_pulse);
input PB_debounced, clk;
output reg PB_one_pulse;
reg PB_debounced_delay;

always @(posedge clk) begin
    PB_one_pulse <= PB_debounced & (!PB_debounced_delay);
    PB_debounced_delay <= PB_debounced;
end

endmodule