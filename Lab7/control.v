module control(	i_instrCode, 
               	o_regDst,
               	o_jump, 
               	o_beq,
		o_bne,
               	o_memToReg,
               	o_aluOp,
               	o_memWrite,
               	o_aluSrc,
               	o_regWrite,
    		o_Ext_Op);
               
input     [5:0]  i_instrCode; 
output reg           o_regDst;
output reg           o_jump; 
output  reg         o_beq, o_bne;
output  reg          o_memToReg;
output  reg  [1:0]   o_aluOp;
output  reg          o_memWrite;
output reg           o_aluSrc;
output  reg          o_regWrite;
output  reg          o_Ext_Op;

always @(*) begin
case(i_instrCode)
6'b000000: begin //R-type
o_regDst = 1;
o_regWrite = 1;
o_Ext_Op = 0;
o_aluSrc = 0;
o_aluOp = 2'b10;
o_bne = 0;
o_beq = 0;
o_jump = 0;
o_memWrite = 0;
o_memToReg = 0;
      end

6'b001000: begin //addi    
    o_regDst = 0;
    o_regWrite = 1;
    o_Ext_Op = 1;
    o_aluSrc = 1;
    o_aluOp = 2'b00;
    o_bne = 0;
    o_beq = 0;
    o_jump = 0;
    o_memWrite = 0;
    o_memToReg = 0;
      end

6'b001010: begin //slti    
    o_regDst = 0;
    o_regWrite = 1;
    o_Ext_Op = 1;
    o_aluSrc = 1;
    o_aluOp = 2'b11;
    o_bne = 0;
    o_beq = 0;
    o_jump = 0;
    o_memWrite = 0;
    o_memToReg = 0;
      end

6'b001100: begin //andi    
    o_regDst = 0;
    o_regWrite = 1;
    o_Ext_Op = 0;
    o_aluSrc = 1;
    o_aluOp = 2'b10;
    o_bne = 0;
    o_beq = 0;
    o_jump = 0;
    o_memWrite = 0;
    o_memToReg = 0;
      end

6'b001101: begin //ori    
    o_regDst = 0;
    o_regWrite = 1;
    o_Ext_Op = 0;
    o_aluSrc = 1;
    o_aluOp = 2'b10;
    o_bne = 0;
    o_beq = 0;
    o_jump = 0;
    o_memWrite = 0;
    o_memToReg = 0;
      end

6'b001110: begin //xori    
    o_regDst = 0;
    o_regWrite = 1;
    o_Ext_Op = 0;
    o_aluSrc = 1;
    o_aluOp = 2'b11;
    o_bne = 0;
    o_beq = 0;
    o_jump = 0;
    o_memWrite = 0;
    o_memToReg = 0;
      end

6'b100011: begin //lw  
    o_regDst = 0;
    o_regWrite = 1;
    o_Ext_Op = 1;
    o_aluSrc = 1;
    o_aluOp = 2'b00;
    o_bne = 0;
    o_beq = 0;
    o_jump = 0;
    o_memWrite = 0;
    o_memToReg = 1;
      end

6'b101011: begin //sw  
    o_regDst = 0;
    o_regWrite = 0;
    o_Ext_Op = 1;
    o_aluSrc = 1;
    o_aluOp = 2'b00;
    o_bne = 0;
    o_beq = 0;
    o_jump = 0;
    o_memWrite = 1;
    o_memToReg = 0;
      end

6'b000100: begin //beq  
    o_regDst = 0;
    o_regWrite = 0;
    o_Ext_Op = 0;
    o_aluSrc = 0;
    o_aluOp = 2'b01;
    o_bne = 0;
    o_beq = 1;
    o_jump = 0;
    o_memWrite = 0;
    o_memToReg = 0;
      end

6'b000101: begin //bne  
    o_regDst = 0;
    o_regWrite = 0;
    o_Ext_Op = 0;
    o_aluSrc = 0;
    o_aluOp = 2'b01;
    o_bne = 1;
    o_beq = 0;
    o_jump = 0;
    o_memWrite = 0;
    o_memToReg = 0;
      end

6'b000010: begin //j  
    o_regDst = 0;
    o_regWrite = 0;
    o_Ext_Op = 0;
    o_aluSrc = 0;
    o_aluOp = 2'b01;
    o_bne = 0;
    o_beq = 0;
    o_jump = 1;
    o_memWrite = 0;
    o_memToReg = 0;
      end

default: begin  
    o_regDst = 1;
    o_regWrite = 1;
    o_Ext_Op = 0;
    o_aluSrc = 0;
    o_aluOp = 2'b10;
    o_bne = 0;
    o_beq = 0;
    o_jump = 0;
    o_memWrite = 0;
    o_memToReg = 0;
      end
endcase
end

endmodule