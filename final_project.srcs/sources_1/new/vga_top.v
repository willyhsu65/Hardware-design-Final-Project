module top(
  input clk,
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

  wire start_db, start_op;

  wire [3-1:0] state;

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
      
endmodule