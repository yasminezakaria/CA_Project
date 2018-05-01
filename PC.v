`timescale 1ns / 1ps
module program_counter (clk,rst,current_pc,pc);
	input clk;
	input rst;
    input 	[31:0] 	current_pc;
    output 	reg	[31:0] 	pc;
	wire	[31:0]	pc_plus_4;
	assign pc_plus_4 = current_pc + 4;
    always @(posedge clk or posedge rst)
	begin
		if (rst)
		begin
			pc <= 32'd0;
		end
		else
		begin
			pc <= pc_plus_4;
		end
	end
	
 endmodule  