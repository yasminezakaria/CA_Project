module	mips_tb;
reg clk;
wire [31:0] ReadData1, ReadData2, memRead;
	
MIPS mips(clk,ReadData1,ReadData2,memRead);
	
initial	begin
clk = 0;
forever	begin
#10 clk	= ~clk;
end
end
							
initial
begin
$monitor("%t	%b	%b	%b",	$time,	ReadData1,ReadData2, clk);
#10
#10 $finish;
end
endmodule