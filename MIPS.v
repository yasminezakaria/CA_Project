module MIPS(clk);

input clk;

//Pipeline Registers
reg [63:0] IFID; 
reg [145:0] IDEX; 
reg [106:0] EXMEM;
reg [70:0] MEMWB;

//Instruction Wire
wire[31:0] instruction;
wire[31:0] PC;

//Control module input
wire [5:0]  opcode;


//Register File inputs
wire [4:0]  rs;
wire [4:0]  rt;
wire [4:0]  rd;


//instruction before and after sign extend inside decode
wire [15:0] inst;
wire [31:0] signextend;


//Register File Outputs
wire[31:0] ReadData1;
wire[31:0] ReadData2;


//Control Signals
wire[7:0] controloutput;
wire[1:0] WB;
wire[2:0] M;
wire[2:0] EX;


//ALU wires
wire RegDst,Branch,MemRead,MemtoReg,ALUOp,memWrite,ALUSrc,RegWrite;
wire[31:0] secondALUInput;
wire passedRegDst;
wire[5:0] ALUControl;
wire[31:0] ALU_Out;
wire[31:0] addResult;

//Memory Wires
wire[31:0] memReadData;
wire[31:0] addResultAddress;

//Write Back wires
wire[4:0] WriteRegister;
wire[31:0] WriteData;


//PC call
//PCSrc & addResultAddress are from EXMEM register
PC prog_c(clk,rst,PCSrc,addResultAddress,PC);


//instruction Memory Call
instruction_memory instmem(PC,instruction);

always@(posedge clk) begin
IFID = {PC,instruction};
end

//Decoding
assign opcode  = IFID[31:26];
assign rs   = IFID[25:21];
assign rt   = IFID[20:16];
assign rd   = IFID[15:11];
assign inst = IFID[15:0];


//Control Call
controller c(clk,opcode,controloutput);
//assign Control Signals
assign WB = {controloutput[7],controloutput[3]};
assign Ex = {controloutput[0],controloutput[4],controloutput[6]};
assign M = {controloutput[1],controloutput[2],controloutput[5]};


//Register File Call
Register_File regfile(rs, rt, WriteRegister, WriteData, RegWrite, clk, ReadData1, ReadData2);

//Sign Extend
assign signextend = {16'b0,inst};

//passing everything to ID/EX
always@(posedge clk) begin
IDEX = {WB,M,EX,IFID[35:31],ReadData1,ReadData2,signextend,IFID[20:16], IFID[15:11]};
end


//Excute Stage
assign ALUSrc = IDEX[138];
assign ALUOp = IDEX[139];
assign RegDst = IDEX[140];
assign secondALUInput = (ALUSrc==0)?IDEX[73:42]:IDEX[41:10];
assign passedRegDst = (RegDst==0)? IDEX[20:16]:IDEX[15:11];
assign ALUControl = (ALUOp == 0)? 6'b111111:IDEX[15:10];

//calling ALU
ALU alu(IDEX[105:74],secondALUInput,IDEX[41:10],IDEX[137:106],ALUControl,ALU_Out,zeroFlag,addResult);

//passing everything to EX/MEM
always@(posedge clk) begin
EXMEM = {IDEX[145:144],IDEX[143:141],addResult,zeroFlag,ALU_Out,IDEX[73:42],passedRegDst};
end

//Memory stage
assign PCSrc = EXMEM[104]&&EXMEM[69];
assign MemWrite = EXMEM[102];
assign MemRead = EXMEM[103];
assign addResultAddress = EXMEM[101:70];

//calling Memory
data_memory mem(memReadData, clk,EXMEM[68:37],EXMEM[36:5],MemWrite,MemRead);

//passing everything to MEM/WB
always@(posedge clk) begin
MEMWB = {EXMEM[106:105],memReadData,EXMEM[68:37],EXMEM[4:0]};
end


//Writeback stage
assign MemToReg = MEMWB[69];
assign RegWrite = MEMWB[70];

assign WriteRegister = MEMWB[4:0];
assign WiteData = (MemToReg==0)?MEMWB[68:37]:MEMWB[36:5];

endmodule

