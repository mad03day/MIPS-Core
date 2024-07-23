`timescale 10ns / 1ns

module spi_tb;

parameter PERIOD = 10;

reg         i_clk, i_rst_n, i_spi_mosi, i_spi_sck, i_spi_cs;
wire o_pwm;

reg  [7:0]  spi_send_buf = 8'h08;

integer i;

SPI_PWM spi_inst(.i_clk(i_clk), 
                    .i_rst_n(i_rst_n), 
                    .i_spi_mosi(i_spi_mosi), 
                    .i_spi_clk(i_spi_sck),
                    .i_spi_cs(i_spi_cs),
                    .o_pwm(o_pwm)
                    );

initial begin
    i_clk = 0;
    forever #(PERIOD/2) i_clk = ~i_clk;
end

initial begin
    i_rst_n = 1'b0;
    i_spi_mosi = 1'b0; 
    i_spi_sck = 1'b0;
    i_spi_cs = 1'b1;


    @(negedge i_clk) i_rst_n = 1;

    repeat (5) @(negedge i_clk);

    i_spi_cs = 1'b0;
        
    for(i=0; i<8; i=i+1) begin
        i_spi_sck = 1'b0;
        i_spi_mosi = spi_send_buf[7-i];
        repeat (5) @(negedge i_clk);
        i_spi_sck = 1'b1;
        repeat (5) @(negedge i_clk);
    end

    i_spi_cs = 1'b1;
    repeat (10) @(negedge i_clk);

    spi_send_buf = 8'h7F;

    repeat (5) @(negedge i_clk);

    i_spi_cs = 1'b0;
        
    for(i=0; i<8; i=i+1) begin
        i_spi_sck = 1'b0;
        i_spi_mosi = spi_send_buf[7-i];
        repeat (5) @(negedge i_clk);
        i_spi_sck = 1'b1;
        repeat (5) @(negedge i_clk);
    end

    i_spi_cs = 1'b1;
    repeat (10) @(negedge i_clk);

    spi_send_buf = 8'hFF;

    repeat (5) @(negedge i_clk);

    i_spi_cs = 1'b0;
        
    for(i=0; i<8; i=i+1) begin
        i_spi_sck = 1'b0;
        i_spi_mosi = spi_send_buf[7-i];
        repeat (5) @(negedge i_clk);
        i_spi_sck = 1'b1;
        repeat (5) @(negedge i_clk);
    end

    i_spi_cs = 1'b1;
    repeat (10) @(negedge i_clk);

        spi_send_buf = 8'h09;

    repeat (5) @(negedge i_clk);

    i_spi_cs = 1'b0;
        
    for(i=0; i<8; i=i+1) begin
        i_spi_sck = 1'b0;
        i_spi_mosi = spi_send_buf[7-i];
        repeat (5) @(negedge i_clk);
        i_spi_sck = 1'b1;
        repeat (5) @(negedge i_clk);
    end

    i_spi_cs = 1'b1;
    repeat (10) @(negedge i_clk);

        spi_send_buf = 8'h00;

    repeat (5) @(negedge i_clk);

    i_spi_cs = 1'b0;
        
    for(i=0; i<8; i=i+1) begin
        i_spi_sck = 1'b0;
        i_spi_mosi = spi_send_buf[7-i];
        repeat (5) @(negedge i_clk);
        i_spi_sck = 1'b1;
        repeat (5) @(negedge i_clk);
    end

    i_spi_cs = 1'b1;
    repeat (10) @(negedge i_clk);

        spi_send_buf = 8'hC5;

    repeat (5) @(negedge i_clk);

    i_spi_cs = 1'b0;
        
    for(i=0; i<8; i=i+1) begin
        i_spi_sck = 1'b0;
        i_spi_mosi = spi_send_buf[7-i];
        repeat (5) @(negedge i_clk);
        i_spi_sck = 1'b1;
        repeat (5) @(negedge i_clk);
    end

    i_spi_cs = 1'b1;
    repeat (2000000) @(negedge i_clk);

/*----------------------------------------------------------*/

    spi_send_buf = 8'h08;

    repeat (5) @(negedge i_clk);

    i_spi_cs = 1'b0;
        
    for(i=0; i<8; i=i+1) begin
        i_spi_sck = 1'b0;
        i_spi_mosi = spi_send_buf[7-i];
        repeat (5) @(negedge i_clk);
        i_spi_sck = 1'b1;
        repeat (5) @(negedge i_clk);
    end

    i_spi_cs = 1'b1;
    repeat (10) @(negedge i_clk);

    spi_send_buf = 8'h01;

    repeat (5) @(negedge i_clk);

    i_spi_cs = 1'b0;
        
    for(i=0; i<8; i=i+1) begin
        i_spi_sck = 1'b0;
        i_spi_mosi = spi_send_buf[7-i];
        repeat (5) @(negedge i_clk);
        i_spi_sck = 1'b1;
        repeat (5) @(negedge i_clk);
    end

    i_spi_cs = 1'b1;
    repeat (10) @(negedge i_clk);

    spi_send_buf = 8'hFF;

    repeat (5) @(negedge i_clk);

    i_spi_cs = 1'b0;
        
    for(i=0; i<8; i=i+1) begin
        i_spi_sck = 1'b0;
        i_spi_mosi = spi_send_buf[7-i];
        repeat (5) @(negedge i_clk);
        i_spi_sck = 1'b1;
        repeat (5) @(negedge i_clk);
    end

    i_spi_cs = 1'b1;
    repeat (10) @(negedge i_clk);

/*-----------------------------------------------------------------*/

    spi_send_buf = 8'h09;

    repeat (5) @(negedge i_clk);

    i_spi_cs = 1'b0;
        
    for(i=0; i<8; i=i+1) begin
        i_spi_sck = 1'b0;
        i_spi_mosi = spi_send_buf[7-i];
        repeat (5) @(negedge i_clk);
        i_spi_sck = 1'b1;
        repeat (5) @(negedge i_clk);
    end

    i_spi_cs = 1'b1;
    repeat (10) @(negedge i_clk);

    spi_send_buf = 8'h05;

    repeat (5) @(negedge i_clk);

    i_spi_cs = 1'b0;
        
    for(i=0; i<8; i=i+1) begin
        i_spi_sck = 1'b0;
        i_spi_mosi = spi_send_buf[7-i];
        repeat (5) @(negedge i_clk);
        i_spi_sck = 1'b1;
        repeat (5) @(negedge i_clk);
    end

    i_spi_cs = 1'b1;
    repeat (10) @(negedge i_clk);

    repeat (200000000) @(negedge i_clk);

    $finish;  
end
  
endmodule
