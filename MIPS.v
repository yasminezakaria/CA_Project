module MIPS(PC,clk);

input clk;
input [31:0] PC;

//Pipeline Registers
reg [35:0] IFID; 
reg [58:0] IDEX; 
reg [31:0] EXMEM; //size not right
reg [31:0] MEMWB; //size not right

//Instruction Wire
wire[31:0] instruction;


//Control module input
wire [5:0]  controlinput;


//Register File inputs
wire [4:0]  rs;
wire [4:0]  rt;
wire [4:0]  rd;


//instruction before and after sign extend inside decode
wire [15:0] inst;
wire [31:0] signextend;


//Register File Outputs
wire[4:0] ReadData1;
wire[4:0] ReadData2;


//Control Signals
wire WB,M;
wire[2:0] EX;



//PC call
//
//

//instruction Memory Call
instruction_memory instmem(PC,instruction);

//storing instruction in IFID
assign PC = PC+4;

always@(posedge clk) begin
IFID = {PC,instruction};
end

//Decoding
assign controlinput  = IFID[31:26];
assign rs   = IFID[25:21];
assign rt   = IFID[20:16];
assign rd   = IFID[15:11];
assign inst = IFID[15:0];


//Control Call
//
//


//Register File Call (4th and 5th port are static for now until we get them from write back)
Register_File regfile(rs, rt, rd, 0, 1'b0, clk, ReadData1, ReadData2);

//Sign Extend
assign signextend = {inst,16'b0};

//passing everything to ID/EX
always@(posedge clk) begin
IDEX = {WB,M,EX,IFID[35:31],ReadData1,ReadData2,signextend,instruction[20:16], instruction[15:11]};
end


endmodule
