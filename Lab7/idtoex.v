module idtoex( i_clk_l, 
    i_NPC2, o_NPC2,
    i_imm26x, o_imm26x,
    i_BUSA, o_BUSA,
    i_BUSB ,o_BUSB,
    i_rd2, o_rd2,
    i_ExtOp, o_ExtOp,
    i_ALUsrc, o_ALUsrc,
    i_ALUctrl, o_ALUctrl,
    i_jump, o_jump,
    i_beq, o_beq,
    i_bne, o_bne,
    i_memWRITE, o_memWRITE,
    i_memToREG, o_memToREG,
    i_RegWRITE, o_toMEM);

input i_clk_l, i_ExtOp, i_ALUsrc, i_jump, i_beq, i_bne, i_memWRITE, i_memToREG, i_RegWRITE;
input [3:0] i_ALUctrl;
input [4:0] i_rd2;
input [25:0] i_imm26x;
input [29:0] i_NPC2;
input [31:0] i_BUSA, i_BUSB;

output reg o_ExtOp,  o_ALUsrc, o_jump, o_beq, o_bne, o_memWRITE, o_memToREG, o_toMEM;
output reg [3:0] o_ALUctrl;
output reg [4:0] o_rd2;
output reg [29:0] o_NPC2;
output reg [31:0] o_BUSA, o_BUSB;
output reg [25:0] o_imm26x;


always@(posedge i_clk_l) begin
    o_NPC2 = i_NPC2;
    o_imm26x = i_imm26x;
    o_rd2 = i_rd2;
    o_BUSA = i_BUSA;
    o_BUSB = i_BUSB;
    o_ExtOp = i_ExtOp;
    o_ALUctrl = i_ALUctrl;
    o_ALUsrc = i_ALUsrc;
    o_jump = i_jump;
    o_beq = i_beq;
    o_bne = i_bne;
    o_memWRITE = i_memWRITE;
    o_memToREG = i_memToREG;
    o_toMEM = i_RegWRITE;
  end
endmodule
