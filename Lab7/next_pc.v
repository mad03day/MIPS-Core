module next_pc(i_inc_PC, i_Branch_E, i_Branch_N, i_J, i_imm26,  i_Zero, o_PCSrs, o_BJ_addr);

parameter nWIDTH = 30;
input [29:0] i_inc_PC;
input i_Branch_E, i_Branch_N, i_J, i_Zero;
input [25:0] i_imm26;
output reg  o_PCSrs;
output [29:0] o_BJ_addr;
reg Beq, Bne;
wire [29:0] addResult;
wire [31:0] signData;

signExtend signExtend_npc(.i_data(i_imm26[15:0]), .en(1'b1), .o_data(signData));

adder#(.WIDTH(nWIDTH)) add(.i_op1(i_inc_PC), .i_op2(signData[29:0]), .o_result(addResult));

assign o_PCSrs = i_J | ((i_Branch_E & i_Zero) | (i_Branch_N &(~i_Zero))) ;

assign o_BJ_addr = i_J ? ({i_inc_PC[29:26], i_imm26}) : addResult;

endmodule