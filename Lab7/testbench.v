`timescale 10ns / 1ns
module testbench;
reg clk, rst_n, spi_clk;
parameter PERIOD = 10;
parameter PERIOD_SPI = 2;

mips mips_tb(.clk(clk), .reset(rst_n), .spi_mod_clk(spi_clk));

initial begin
rst_n = 0;
#8 rst_n = 1;

end
initial begin
    clk = 0;
    forever #(PERIOD/2) clk = ~clk;
end

initial begin
    spi_clk = 0;
    forever #(PERIOD_SPI/2) spi_clk = ~spi_clk;
end

initial begin
#12000000 $finish;
end

endmodule
