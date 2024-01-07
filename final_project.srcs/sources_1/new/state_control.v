`timescale 1ns/1ps

module state_control(clk, rst, start, state);
input clk, rst, start;
output [3-1:0] state;

reg [3-1:0] state, next_state;

parameter [3-1:0] IDLE = 3'd0;
parameter [3-1:0] PLAY = 3'd1;
parameter [3-1:0] FINISH = 3'd2;

always @(posedge clk) begin
    if(rst) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    if(state == IDLE) begin
        if(start) begin
           next_state = PLAY; 
        end
        else begin
            next_state = IDLE;
        end
    end
    else begin
        next_state = PLAY;
    end
end

endmodule