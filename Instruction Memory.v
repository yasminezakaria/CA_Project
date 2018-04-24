// this module reponsible for returning instruction needed
`timescale 1ns / 1ps
module instruction_memory(address,instruction);
	input [31:0]	address;
    output 	[31:0] 	instruction;
    reg	[31:0] instruction_memory	[255:0];
	initial
	begin
		$readmemh("program.mips",instruction_memory);
	end
	
	assign instruction = instruction_memory[address[9:2]];
	
 endmodule  