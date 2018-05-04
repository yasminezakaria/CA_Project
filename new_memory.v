`timescale 1ns / 1ps

module dataMem(memRdata, addres, memWdata, memW,MemR,clk);
(  memRdata, clk,addres,  memWdata,memW,memR ); 

input [31:0] addres, memWdata;
input memW,memR, clk;
output [31:0] memRdata;
reg [7:0] datamem[1023:0];
reg [31:0] temp;


        
buf #1000 buf0(memRdata[0],temp[0]),
   buf1(memRdata[1],temp[1]),
   buf2(memRdata[2],temp[2]),
   buf3(memRdata[3],temp[3]),
   buf4(memRdata[4],temp[4]),
   buf5(memRdata[5],temp[5]),
   buf6(memRdata[6],temp[6]),
   buf7(memRdata[7],temp[7]),
   buf8(memRdata[8],temp[8]),
   buf9(memRdata[9],temp[9]),
   buf10(memRdata[10],temp[10]),
   buf11(memRdata[11],temp[11]),
   buf12(memRdata[12],temp[12]),
   buf13(memRdata[13],temp[13]),
   buf14(memRdata[14],temp[14]),
   buf15(memRdata[15],temp[15]),
   buf16(memRdata[16],temp[16]),
   buf17(memRdata[17],temp[17]),
   buf18(memRdata[18],temp[18]),
   buf19(memRdata[19],temp[19]),
   buf20(memRdata[20],temp[20]),
   buf21(memRdata[21],temp[21]),
   buf22(memRdata[22],temp[22]),
   buf23(memRdata[23],temp[23]),
   buf24(memRdata[24],temp[24]),
   buf25(memRdata[25],temp[25]),
   buf26(memRdata[26],temp[26]),
   buf27(memRdata[27],temp[27]),
   buf28(memRdata[28],temp[28]),
   buf29(memRdata[29],temp[29]),
   buf30(memRdata[30],temp[30]),
   buf31(memRdata[31],temp[31]);

always @(posedge clk)
 if (memW)
 begin
  datamem[addres]=memWdata[31:24];
  datamem[addres+1]=memWdata[23:16];
  datamem[addres+2]=memWdata[15:8];
  datamem[addres+3]=memWdata[7:0];
 end
 
always @(addres or datamem[addres] or datamem[addres+1] or datamem[addres+2] or datamem[addres+3])
begin
 temp={datamem[addres],datamem[addres+1],datamem[addres+2],datamem[addres+3]};
end


endmodule