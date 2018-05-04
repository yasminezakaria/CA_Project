 `timescale 1ns / 1ps

 module testbench_mips;  
      // Inputs  
      parameter ClockDelay = 5000;//used as nop
      reg clk;  
      reg reset;  
      // Outputs  
      wire [15:0] pc_out;  
      wire [15:0] alu_result;//,reg3,reg4;  
   
      PC procount=  PC(clk,reset,pcsrc,result,prc_out);
      //PC pc(clk,rst,PCSrc,addResultAddress,pc);
      MIPS mtest= MIPS(procount,clk); 
      initial begin  
           clk = 0;  
           forever #10 clk = ~clk;  
      end  
      initial begin  
           // next line is for tracing 
           //$monitor ("register 3=%d, register 4=%d", reg3,reg4);  
           reset = 1;  
           // Wait 100 ns for the reset to finish  
           #100;  
     reset = 0;  
           
      end
      //add this part to insert bubble in case of hazards  
      //always #(ClockDelay/2) clk = ~clk;

      //initial 
      //begin
      //      reset = 1;
        //    #(ClockDelay/4);
          //  reset = 0;
      //end
 endmodule 