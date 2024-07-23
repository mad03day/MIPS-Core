module  extomem(i_clk_l, i_toWB, i_memWRITE, i_memToREG, i_ALUout, i_datamem, i_rd3, o_memWRITE, o_memToREG, o_toWB, o_ALUout, o_datamem, o_rd3);

input i_clk_l, i_toWB, i_memWRITE, i_memToREG;
input [31:0] i_ALUout, i_datamem;
input [4:0] i_rd3;

output reg o_memWRITE, o_memToREG, o_toWB;
output reg [31:0] o_ALUout, o_datamem;
output reg [4:0] o_rd3;

always@(posedge i_clk_l) begin

    o_memWRITE = i_memWRITE;
    o_memToREG = i_memToREG;
    o_toWB = i_toWB;
    o_ALUout = i_ALUout;
    o_datamem = i_datamem;
    o_rd3 = i_rd3;

end
endmodule