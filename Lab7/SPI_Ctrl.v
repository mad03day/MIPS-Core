module SPI_Ctrl(i_clk, i_reset, i_spi_data, o_mosi, o_cs, o_clk, o_busy);

input i_clk;
input i_reset;
input [31:0] i_spi_data;

/*
i_spi_data memory map

0000 0000 -- data bits          [7:0]
0         -- Start transfer bit [14]

[31:15] & [13:8] -- reserved bits
*/

reg busy, cs, clk, mosi;
reg [7:0]   data_spi;
reg [3:0]   counter_transfer;

output o_mosi;
output o_cs;
output o_clk;
output o_busy;

assign o_mosi = mosi;
assign o_cs = cs;
assign o_clk = clk;
assign o_busy = busy;

always@(negedge i_reset)
begin
    data_spi <= 8'd0;
    counter_transfer <= 3'd0;
    busy <= 1'b0;
    cs <= 1'b1;
end

always @(*)
begin
    if((busy == 1) && ((mosi == 1) || (mosi == 0)))
        clk <= i_clk;
end


always@(negedge i_clk)
begin
    if(busy == 1)
    begin
        if(counter_transfer < 8)
        begin
            mosi <= data_spi[7-counter_transfer];
            counter_transfer <= counter_transfer + 1;
        end
        else
        begin
            busy <= 1'b0;
            cs <= 1'b1; 
        end
    end
end

always@(posedge i_clk)
begin
    if(i_spi_data[14] == 1'b1)
    begin
        if(busy == 1'b0)
        begin 
            data_spi <= i_spi_data[7:0];
            counter_transfer <= 4'd0;
            busy <= 1'b1;
            cs <= 1'b0;
        end            
    end
end


endmodule