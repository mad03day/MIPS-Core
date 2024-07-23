module iftoid(i_clk_l, i_NPC, i_inst, o_NPC, o_inst);

input i_clk_l;
input [29:0] i_NPC;
input [31:0] i_inst;

output reg [29:0] o_NPC;
output reg [31:0] o_inst;

always@(posedge i_clk_l) begin
    
  o_NPC = i_NPC;
  o_inst = i_inst;

  end
endmodule
