module memtowb (i_WBdata, i_rd4, i_wb, i_clk_l, o_WBdata, o_rd4, o_wb);

input [31:0] i_WBdata;
input [4:0] i_rd4;
input i_wb, i_clk_l;

output reg [31:0] o_WBdata;
output reg [4:0] o_rd4;
output reg o_wb;

always @ (posedge i_clk_l) begin

    o_WBdata = i_WBdata;
    o_rd4 = i_rd4;
    o_wb = i_wb;
 
end
endmodule