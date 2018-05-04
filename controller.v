module controller(clk,opcode,out);
input [5:0]opcode;
output reg [7:0]out;
input clk;
always @(posedge clk)
begin
//RegDst-Branch-MemRead-MemtoReg-ALUOp-memWrite-AluSrc-RegWrite
case(opcode)
//R-type
6'b000000 : out<=8'b10001001;
//lw
6'b100011 : out<=8'b00110011;
//sw
6'b101011 : out<=8'b00000110;
//branch
6'b000100 : out<=8'b01001000;
//addi
6'b001000 : out<=8'b00001011;
//lh
6'b100001 : out<=8'b00110011;
//lhu
6'b100101 : out<=8'b00110011;
default : out<=8'b0000000;
endcase
end
endmodule