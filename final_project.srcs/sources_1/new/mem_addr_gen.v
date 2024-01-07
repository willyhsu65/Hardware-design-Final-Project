module mem_addr_gen(
    input clk,
    input rst,
    input [3-1:0] state,
    input [9:0] h_cnt,
    input [9:0] v_cnt,
    output [16:0] pixel_addr
    );

    reg [16:0] pixel_addr;
    reg [7:0] position;
    reg [2-1:0] counter, next_counter;
    reg dir, next_dir;
    
    reg [3-1:0] jump_counter, next_jump_counter;
    reg [2-1:0] jump_dir, next_jump_dir;
    

    always @(*) begin
        if(state == 3'd0) begin
            if((v_cnt >> 1) >= 80 && (v_cnt >> 1) <= 110) begin
                if((h_cnt >> 1) >= 125 && (h_cnt >> 1) <= 195) begin
                    pixel_addr = (((h_cnt>>1) - 15)+320*((v_cnt>>1) + 100))% 76800;
                end
                else begin
                    pixel_addr = 16'd0;
                end
            end
            else if((v_cnt >> 1) >= 140 && (v_cnt >> 1) <= 165) begin
                if((h_cnt >> 1) >= 130 && (h_cnt >> 1) <= 175) begin
                    pixel_addr = (((h_cnt>>1) + 60)+320*((v_cnt>>1) - 10))% 76800;
                end
                else begin
                    pixel_addr = 16'd0;
                end
            end
            else if((h_cnt >> 1) >= 280 && (h_cnt >> 1) <= 295) begin
                if(counter == 2'd0) begin
                    if((v_cnt >> 1) >= 220 && (v_cnt >> 1) <= 235) begin
                        pixel_addr = (((h_cnt>>1))+320*((v_cnt>>1)))% 76800;
                    end
                    else begin
                        pixel_addr = 16'd0;
                    end
                end
                else if(counter == 2'd1) begin
                    if((v_cnt >> 1) >= 195 && (v_cnt >> 1) <= 210) begin
                        pixel_addr = (((h_cnt>>1))+320*((v_cnt>>1)))% 76800;
                    end
                    else begin
                        pixel_addr = 16'd0;
                    end
                    
                end
                else begin
                    if((v_cnt >> 1) >= 170 && (v_cnt >> 1) <= 185) begin
                        pixel_addr = (((h_cnt>>1))+320*((v_cnt>>1)))% 76800;
                    end
                    else begin
                        pixel_addr = 16'd0;
                    end
                end
            end
            else begin
                pixel_addr = 16'd0;
            end
        end
        else if(state == 3'd1) begin
            if((h_cnt >> 1) >= 32 && (h_cnt >> 1) <= 45) begin
                if(jump_counter == 3'd0) begin
                    if((v_cnt >> 1) >= 140 && (v_cnt >> 1) <= 155) begin
                        pixel_addr = (((h_cnt>>1)+250)+320*((v_cnt>>1) +80))% 76800;
                    end
                    else begin
                        if((v_cnt >> 1) <= 160) begin
                            pixel_addr = 16'd340;
                        end
                        else begin
                            pixel_addr = ((((h_cnt>>1) % 90) + 5)+320*((v_cnt>>1) - 20))% 76800;
                        end
                    end
                end
                else if(jump_counter == 3'd1) begin
                    if((v_cnt >> 1) >= 120 && (v_cnt >> 1) <= 135) begin
                        pixel_addr = (((h_cnt>>1)+250)+320*((v_cnt>>1) +75))% 76800;
                    end
                    else begin
                        if((v_cnt >> 1) <= 160) begin
                            pixel_addr = 16'd340;
                        end
                        else begin
                            pixel_addr = ((((h_cnt>>1) % 90) + 5)+320*((v_cnt>>1) - 20))% 76800;
                        end
                    end
                end
                else if(jump_counter == 3'd2) begin
                    if((v_cnt >> 1) >= 100 && (v_cnt >> 1) <= 115) begin
                        pixel_addr = (((h_cnt>>1)+250)+320*((v_cnt>>1) +70))% 76800;
                    end
                    else begin
                        if((v_cnt >> 1) <= 160) begin
                            pixel_addr = 16'd340;
                        end
                        else begin
                            pixel_addr = ((((h_cnt>>1) % 90) + 5)+320*((v_cnt>>1) - 20))% 76800;
                        end
                    end
                end
                else if(jump_counter == 3'd3) begin
                    if((v_cnt >> 1) >= 80 && (v_cnt >> 1) <= 95) begin
                        pixel_addr = (((h_cnt>>1)+250)+320*((v_cnt>>1) +115))% 76800;
                    end
                    else begin
                        if((v_cnt >> 1) <= 160) begin
                            pixel_addr = 16'd340;
                        end
                        else begin
                            pixel_addr = ((((h_cnt>>1) % 90) + 5)+320*((v_cnt>>1) - 20))% 76800;
                        end
                    end
                end
                else if(jump_counter == 3'd4) begin
                    if((v_cnt >> 1) >= 60 && (v_cnt >> 1) <= 75) begin
                        pixel_addr = (((h_cnt>>1)+250)+320*((v_cnt>>1) +110))% 76800;
                    end
                    else begin
                        if((v_cnt >> 1) <= 160) begin
                            pixel_addr = 16'd340;
                        end
                        else begin
                            pixel_addr = ((((h_cnt>>1) % 90) + 5)+320*((v_cnt>>1) - 20))% 76800;
                        end
                    end
                end
                else if(jump_counter == 3'd5) begin
                    if((v_cnt >> 1) >= 40 && (v_cnt >> 1) <= 55) begin
                        pixel_addr = (((h_cnt>>1)+250)+320*((v_cnt>>1) +155))% 76800;
                    end
                    else begin
                        if((v_cnt >> 1) <= 160) begin
                            pixel_addr = 16'd340;
                        end
                        else begin
                            pixel_addr = ((((h_cnt>>1) % 90) + 5)+320*((v_cnt>>1) - 20))% 76800;
                        end
                    end
                end
                else begin
                    if((v_cnt >> 1) >= 20 && (v_cnt >> 1) <= 35) begin
                        pixel_addr = (((h_cnt>>1)+250)+320*((v_cnt>>1) +150))% 76800;
                    end
                    else begin
                        if((v_cnt >> 1) <= 160) begin
                            pixel_addr = 16'd340;
                        end
                        else begin
                            pixel_addr = ((((h_cnt>>1) % 90) + 5)+320*((v_cnt>>1) - 20))% 76800;
                        end
                    end
                end                  
            end
            else begin
                if((v_cnt >> 1) <= 160) begin
                    pixel_addr = 16'd340;
                end
                else begin
                    pixel_addr = ((((h_cnt>>1) % 90) + 5)+320*((v_cnt>>1) - 20))% 76800;
                end
            end
        end
        else begin
            pixel_addr = ((((h_cnt>>1) % 90) + 5)+320*(v_cnt>>1))% 76800;
        end
    end   

// initial bird animate

    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            counter <= 2'd0;
            dir <= 1'b0;
        end
        else begin
            counter <= next_counter;
            dir <= next_dir;
        end
    end

    always @(*) begin
        if(next_dir) begin
            next_counter = counter - 2'd1;
        end
        else begin
            next_counter = counter + 2'd1;
        end
    end

    always @(*) begin
        if(counter == 2'd0) begin
            next_dir = 1'b0;
        end
        else if(counter == 2'd2) begin
            next_dir = 1'b1;
        end
        else begin
            next_dir = dir;
        end
    end
    
// play jumping scene
    
    always @ (posedge clk or posedge rst) begin
        if(rst || state != 3'd1) begin
            jump_counter <= 3'd0;
            jump_dir <= 2'd0;
        end
        else begin
            jump_counter <= next_jump_counter;
            jump_dir <= next_jump_dir;
        end
    end
    
    always @(*) begin
        if(next_jump_dir == 2'd1) begin
            next_jump_counter = jump_counter - 3'd1;
        end
        else if(next_jump_dir == 2'd0)begin
            next_jump_counter = jump_counter + 3'd1;
        end
        else begin
            next_jump_counter = jump_counter;        
        end
    end
    
    always @(*) begin
        if(jump_counter == 3'd0) begin
            next_jump_dir = 2'd0;
        end
        else if(jump_counter == 3'd6) begin
            next_jump_dir = 2'd1;
        end
        else begin
            next_jump_dir = jump_dir;
        end
    end
    
endmodule