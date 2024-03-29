module PC (clk,rst,PCSrc,addResultAddress,pc);
	input clk,rst,PCSrc;
	input[31:0]addResultAddress;
    output 	reg	[31:0] 	pc;
	wire	[31:0]	pc_plus_4;
	assign pc_plus_4 = pc + 4;
    always @(posedge clk or posedge rst)
	begin
		if (rst)
		begin
			pc <= 32'd0;
		end
		else
		begin
			pc = (PCSrc)?addResultAddress:pc_plus_4;
		end
	end
	
 endmodule  
