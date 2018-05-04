module MIPS(clk);

input clk;

//Pipeline Registers
reg [63:0] IFID; 
reg [58:0] IDEX; 
reg [31:0] EXMEM; //size not right
reg [70:0] MEMWB;

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
wire controloutput;
wire[1:0] WB;
wire[2:0] M;
wire RegDst,Branch,MemRead,MemtoReg,ALUOp,memWrite,AluSrc,RegWrite;
wire[2:0] EX;

//ALU
wire aluresult;

//Data Memory
wire readDataM;



//PC call
//TODO: PCSrc & addResultAddress should be gotten from EXMEM register
PC pc(clk,rst,PCSrc,addResultAddress,pc);
//

//instruction Memory Call
instruction_memory instmem(PC,instruction);

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
controller c(clk,controlinput,controloutput);

//assign Control Signals
assign RegDst = controloutput[0];
assign Branch = controloutput[1];
assign MemRead = controloutput[2];
assign MemtoReg = controloutput[3];
assign ALUOp = controloutput[4];
assign memWrite = controloutput[5];
assign AluSrc = controloutput[6];
assign RegWrite = controloutput[7];
assign WB = {controloutput[7],controloutput[3]};
assign Ex = {controloutput[0],controloutput[4],controloutput[6]};
assign M = {controloutput[1],controloutput[2],controloutput[5]};


//TODO: Register File Call (4th and 5th port are static for now until we get them from write back)
Register_File regfile(rs, rt, rd, 0, 1'b0, clk, ReadData1, ReadData2);

//Sign Extend
assign signextend = {inst,16'b0};

//passing everything to ID/EX
always@(posedge clk) begin
IDEX = {WB,M,EX,IFID[35:31],ReadData1,ReadData2,signextend,instruction[20:16], instruction[15:11]};
end

//passing everything to MEM/WB
always@(posedge clk) begin
//last take it from EX/MEM
MEMWB = {RegWrite,MemtoReg,aluresult,readDataM,last};
end

endmodule
