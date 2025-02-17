module mips(clk, reset, spi_mod_clk);

input clk; 
input reset;
input spi_mod_clk;

wire [31:0] instruct;
wire [31:0] i_inst;
wire [5:0] op_core = instruct [31:26];

wire [4:0] Rs = instruct [25:21];

wire [4:0] Rt = instruct [20:16];

wire RegDst;

wire [4:0] i_Rd = RegDst ? instruct [15:11] : Rt;
wire [4:0] Rd, Rd2, Rd3, Rd4;
wire [5:0] func = instruct [5:0];

wire [25:0] i_imm26 = instruct [25:0];
wire [25:0] imm26;

wire [15:0] imm16 = imm26 [15:0];


wire i_ExtOp, ExtOp;
wire i_RegWrite, RegWrite, RegWrite2, RegWrite_O;
wire i_aluSrc, aluSrc;
wire [1:0] aluOp;
wire i_memWrite, memWrite, memWrite2;
wire i_memToReg, memToReg, memToReg2;
wire i_beq, beq, i_bne, bne;
wire i_jump, jump;
wire zero;
wire [31:0] PC_ROM, i_PC_ROM;
wire [31:0] NEXT_PC = PC_ROM + 4;
wire [31:0] NEXT_PC_o;
wire [31:0] NEXT_PC_2o;
wire PCSrs;
wire [31:0] JUMP_ADDR;
wire [31:0] BusA, i_BusA, i_BusB, BusB, BusB2, BusW, BusW3, BusW2;
wire [4:0] wr_addr;
wire [31:0] Ext_mux_data;
wire [31:0] Op1, Op2, Res_ALU, Res_ALU2;
wire [3:0] i_ALUCtrl, ALUCtrl;
wire [31:0] RAM_Out;

wire [31:0] spi_data_reg;


wire spi_mosi, spi_clk, spi_cs, busy, pwm;

assign PC_ROM[1:0] = 0;


control control_mips(	.o_regDst(RegDst),		 
			.o_regWrite(i_RegWrite), 
			.o_aluSrc(i_aluSrc), 
			.o_aluOp(aluOp), 
			.o_memWrite(i_memWrite), 
			.o_memToReg(i_memToReg),
                    	.i_instrCode(op_core), 
			.o_jump(i_jump), 
			.o_beq(i_beq),
			.o_bne(i_bne),
			.o_Ext_Op(i_ExtOp));

next_pc next_pc_mips(	.i_inc_PC(NEXT_PC_2o),
			.i_Branch_E(beq), 
			.i_Branch_N(bne),
			.i_J(jump), 
			.i_imm26(imm26),  
			.i_Zero(zero), 
			.o_PCSrs(PCSrs), 
			.o_BJ_addr(JUMP_ADDR[31:2]));

mux2in1 PC_addr_mux(	.i_dat0(NEXT_PC),
			.i_dat1(JUMP_ADDR),
			.i_control(PCSrs),
			.o_dat(i_PC_ROM));

pc PC_mips	(	.i_clk(clk), 
				.i_rst_n(reset), 
				.i_pc(i_PC_ROM), 
				.o_pc(PC_ROM)
			);

rom ROM_mips(	.i_addr(PC_ROM[31:2]),
				.o_data(i_inst)
			);

iftoid IfToId(	.i_clk_l(clk),
				.i_NPC(NEXT_PC[31:2]),
				.i_inst(i_inst),
				.o_NPC(NEXT_PC_o),
				.o_inst(instruct)
			);

mux2in1 Reg_mux_mips(	.i_dat0(Rt),
			.i_dat1(Rd),
			.i_control(RegDst),
			.o_dat(wr_addr));

regFile RegFile_mips(	.i_clk(clk), 
               		.i_raddr1(Rs), 
	 	        .i_raddr2(Rt),
               		.i_waddr(Rd4), 
               		.i_wdata(BusW3), 
               		.i_we(RegWrite_O),
               		.o_rdata1(i_BusA),
               		.o_rdata2(i_BusB)); 

idtoex IdToEx(		.i_clk_l(clk),
			.i_NPC2(NEXT_PC_o),
			.o_NPC2(NEXT_PC_2o),
			.i_imm26x(i_imm26),
			.o_imm26x(imm26),
			.i_BUSA(i_BusA),
			.o_BUSA(BusA),
			.i_BUSB(i_BusB),
			.o_BUSB(BusB),
			.i_rd2(i_Rd),
			.o_rd2(Rd),
			.i_ExtOp(i_ExtOp),
			.o_ExtOp(ExtOp),
			.i_ALUsrc(i_aluSrc),
			.o_ALUsrc(aluSrc),
			.i_ALUctrl(i_ALUCtrl),
			.o_ALUctrl(ALUCtrl),
			.i_jump(i_jump),
			.o_jump(jump),
			.i_beq(i_beq),
			.o_beq(beq),
			.i_bne(i_bne),
			.o_bne(bne),
			.i_memWRITE(i_memWrite),
			.o_memWRITE(memWrite),
			.i_memToREG(i_memToReg),
			.o_memToREG(memToReg),
			.i_RegWRITE(i_RegWrite),
			.o_toMEM(RegWrite));

signExtend ALU_sign(	.i_data(imm16),
			.en(ExtOp),
			.o_data(Ext_mux_data));

mux2in1 ALU_mux(	.i_dat0(BusB),
			.i_dat1(Ext_mux_data),
			.i_control(aluSrc),
			.o_dat(Op2));

alu ALU_mips(		.i_op1(BusA), 
			.i_op2(Op2), 
			.i_control(ALUCtrl), 
			.o_result(Res_ALU), 
			.o_zf(zero));

extomem ExToMem(	.i_clk_l(clk), 
			.i_toWB(RegWrite), 
			.i_memWRITE(memWrite), 
			.i_memToREG(memToReg), 
			.i_ALUout(Res_ALU), 
			.i_datamem(BusB), 
			.i_rd3(Rd), 
			.o_memWRITE(memWrite2), 
			.o_memToREG(memToReg2), 
			.o_toWB(RegWrite2), 
			.o_ALUout(Res_ALU2), 
			.o_datamem(BusB2), 
			.o_rd3(Rd3));

ram RAM_mips(		.i_clk(clk), 
			.i_addr(Res_ALU2), 
			.i_data(BusB2), 
			.i_we(memWrite2),
			.i_busy(busy), 
			.o_data(RAM_Out),
			.o_spi_data(spi_data_reg)
			);

mux2in1 RAM_mux(	.i_dat0(Res_ALU2),
			.i_dat1(RAM_Out),
			.i_control(memToReg2),
			.o_dat(BusW2));

memtowb memToWb(	.i_WBdata(BusW2), 
			.i_rd4(Rd3), 
			.i_wb(RegWite2), 
			.i_clk_l(clk),
			.o_WBdata(BusW3), 
			.o_rd4(Rd4),
			.o_wb(RewWrite_O));


aluControl ALU_Cntr(	.i_aluOp(aluOp), 
			.i_func(func), 
			.o_aluControl(i_ALUCtrl));
      	
SPI_Ctrl spi		(	.i_clk(clk), 
						.i_reset(reset), 
						.i_spi_data(spi_data_reg), 
						.o_mosi(spi_mosi), 
						.o_cs(spi_cs), 
						.o_clk(spi_clk),
						.o_busy(busy)
					);

SPI_PWM pereph		(	.i_clk(spi_mod_clk), 
						.i_rst_n(reset), 
						.i_spi_mosi(spi_mosi), 
						.i_spi_clk(spi_clk), 
						.i_spi_cs(spi_cs), 
						.o_pwm(pwm)
					);



endmodule