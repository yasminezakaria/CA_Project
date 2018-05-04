module ALU( input [31:0] A,B,addressSignExtend,pc,
 input [5:0] Sel,
 output [31:0] ALU_Out,
 output reg zeroFlag,
 output reg [31:0] addResult);

reg [31:0] Res;
assign ALU_Out = Res;
always @(*)
begin
addResult = (addressSignExtend << 2) + pc;
case(Sel)
 6'b100000: begin Res = A + B; zeroFlag = (A==B)?1'b1:1'b0; end // Add
 6'b100010: begin Res = A - B; zeroFlag = (A==B)?1'b1:1'b0; end// subtract
 6'b100100: begin Res = A & B; zeroFlag = (A==B)?1'b1:1'b0; end// And
 6'b100101: begin Res = A | B; zeroFlag = (A==B)?1'b1:1'b0; end// Or
 6'b000000: begin Res = A << B; zeroFlag = (A==B)?1'b1:1'b0; end// shift left
 6'b000010:  begin Res = A >> B; zeroFlag = (A==B)? 1'b1:1'b0; end // shift right
 6'b101010:	begin Res = (A < B) ? 1 : 0; zeroFlag = (A==B)?1'b1:1'b0; end //slt
 6'b101011:	begin Res = (A < B) ? 1 : 0; zeroFlag = (A==B)?1'b1:1'b0; end //sltu
 endcase
 end
endmodule