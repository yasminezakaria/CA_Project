 module data_memory  
 (  memRdata, clk,addres,  memWdata,memW,memR );  
        output [31:0] memRdata;
        input clk;
        input [31:0] addres;
        input [31:0] memWdata;
        input memR;
        input memW;
        
      integer i;  
      reg [15:0] ram [255:0];  
      wire [7 : 0] ram_addr = addres[8 : 1];  
      initial begin  
           for(i=0;i<256;i=i+1)  
                ram[i] <= 16'd0;  
      end  
      always @(posedge clk) begin  
           if (memW)  
                ram[ram_addr] <= memWdata;  
      end  
      assign memRdata = (memR==1'b1) ? ram[ram_addr]: 16'd0;   
 endmodule 