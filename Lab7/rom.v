module rom
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=8)
(
	input [(ADDR_WIDTH-1):0] i_addr,
	output reg [(DATA_WIDTH-1):0] o_data
);

reg [(DATA_WIDTH - 1):0] mem_block [($pow(2, ADDR_WIDTH) - 1) : 0];

initial $readmemh("rom_init_tb.hex", mem_block);

assign o_data = mem_block [i_addr];

endmodule
