module jdoodle(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);

input [1:0] ReadRegister1,ReadRegister2,WriteRegister;
input [31:0] WriteData;
input RegWrite,Clk;

output reg [4:0] ReadData1,ReadData2;

reg [31:0] Registers [3:0];

always@(posedge Clk or posedge RegWrite)begin

Registers[WriteRegister] <= WriteData;

end


always@(negedge Clk)
begin

if(ReadRegister1 == 0)
ReadData1 <= 0;
else
ReadData1 <= Registers[ReadRegister1];
if(ReadRegister2 == 0)
ReadData2 <= 0;
else
ReadData2 <= Registers[ReadRegister2];
end


endmodule