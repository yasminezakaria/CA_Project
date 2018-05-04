module controller(clk,opcode,out);
input [5:0]opcode;
output reg [6:0]out;
input clk;
always @(posedge clk)
begin
case(opcode)
6'b000000 : out<=7'b1000001;
6'b100011 : out<=7'b0011011;
6'b101011 : out<=7'b0000110;
6'b000100 : out<=7'b0100000;
6'b001000 : out<=7'b0000011;
6'b100001 : out<=7'b0011011;
6'b100101 : out<=7'b0011011;
default : out<=7'b0000000;
endcase
end
endmodule

module tb;
reg clk;
reg [5:0] opcode;
wire [6:0] out;

controller c(clk,opcode,out);

initial begin
clk = 0;
forever begin
#5 clk = ~clk;
end
end

initial
begin
$monitor("%b ", out);

#5 opcode <= 6'b000000;
#10 opcode <= 6'b100011;
#15 opcode <= 6'b101011;
#20 opcode <= 6'b000100;
#25 opcode <= 6'b001000;
#30 opcode <= 6'b100001;
#35 opcode <= 6'b100101;
#40 $finish;

end
endmodule