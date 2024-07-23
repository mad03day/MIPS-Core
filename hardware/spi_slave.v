module simple_spi(i_clk, i_rst_n, i_spi_mosi, i_spi_sck, i_spi_cs, i_cmplt, o_data, o_cmplt);

input i_clk;
input i_rst_n;
input i_spi_mosi;
input i_spi_sck;
input i_spi_cs;
input i_cmplt;
output [7:0] o_data;
output o_cmplt;

wire sck_rs_edg;
wire tr_cmplt;

reg [7:0] user_reg_ff;
reg [7:0] spi_dat_ff;
reg [2:0] sck_sync_ff;
reg [2:0] cs_sync_ff;
reg [1:0] mosi_sync_ff;


assign o_data = user_reg_ff;
assign sck_rs_edg = ~sck_sync_ff[2] & sck_sync_ff[1];
assign tr_cmplt = ~cs_sync_ff[2] & cs_sync_ff[1];
assign o_cmplt = tr_cmplt;


always @(posedge i_clk, negedge i_rst_n)
    if (~i_rst_n) 
    begin
        sck_sync_ff <= 3'b000;
    end 
    else 
    begin
        sck_sync_ff <= {sck_sync_ff[1:0], i_spi_sck};
    end

always @(posedge i_clk, negedge i_rst_n)
    if (~i_rst_n) 
    begin
        cs_sync_ff <= 3'b111;
    end 
    else 
    begin
        cs_sync_ff <= {cs_sync_ff[1:0], i_spi_cs};
    end

always @(posedge i_clk)
    mosi_sync_ff <= {mosi_sync_ff[0], i_spi_mosi};

always @(posedge i_clk)
    if (sck_rs_edg)
        spi_dat_ff <= {spi_dat_ff[6:0], mosi_sync_ff[1]};

always @(posedge i_clk)
    if (tr_cmplt)
        user_reg_ff <= spi_dat_ff;

endmodule