module ram(i_clk, i_addr, i_data, i_we, i_busy, o_data, o_spi_data);

parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 32; //32 4-byte words 

input                     i_clk, i_we, i_busy;
input   [ADDR_WIDTH-1:0]  i_addr;
input   [DATA_WIDTH-1:0]  i_data;

output  [DATA_WIDTH-1:0]  o_data;
inout   [DATA_WIDTH-1:0]  o_spi_data;

reg [(DATA_WIDTH-1):0] mem_block [31:0];

initial $readmemh("set_ram_zero.dat", mem_block);

assign o_data = mem_block [i_addr];

assign mem_block[31][14] = i_busy; 
assign o_spi_data = mem_block[31];

always@(posedge i_clk) begin
    if(i_we) begin
        mem_block [i_addr] <= i_data;
    end
end

endmodule