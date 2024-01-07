module top(
    input clk,
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    input rst,
    input start,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output hsync,
    output vsync
);
    wire [11:0] data;
    wire clk_25MHz;
    wire clk_22;
    wire [16:0] pixel_addr;
    wire [11:0] pixel;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480
    
//button
    wire start_db, start_op;
    
//state transform
    wire [3-1:0] state;
    
//keyboard
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire been_ready;
    
    reg jump;
    
    Debounce debounce_inst(start, clk, start_db);
    OnePulse onepulse_inst(start_db, clk, start_op);
    
    assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? (pixel == 12'd0 && state == 3'd1) ? {4'd5, 4'd12, 4'd12} : pixel:12'h0;
    
    state_control state_control_inst(clk, rst, start_op, state);
    
    
    clock_divisor clk_wiz_0_inst(
    .clk(clk),
    .clk1(clk_25MHz),
    .clk22(clk_22)
    );
    
    mem_addr_gen mem_addr_gen_inst(
    .clk(clk_22),
    .rst(rst),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .jump(jump),
    .pixel_addr(pixel_addr),
    .state(state)
    );
    
    
    blk_mem_gen_0 blk_mem_gen_0_inst(
    .clka(clk_25MHz),
    .wea(0),
    .addra(pixel_addr),
    .dina(data[11:0]),
    .douta(pixel)
    ); 
    
    vga_controller   vga_inst(
    .pclk(clk_25MHz),
    .reset(rst),
    .hsync(hsync),
    .vsync(vsync),
    .valid(valid),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt)
    );
    
//keyboard

    parameter [8:0] KEY_CODES_SPACE = 9'b0_0010_1001; // SPACE => 29
    
    KeyboardDecoder key_de (
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(been_ready),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk)
    );
    always @ (*) begin
        if (key_down[KEY_CODES_SPACE] == 1'b1) begin
            jump = 1'b1;
        end
        else begin
            jump = 1'b0;
        end
    end
         
endmodule