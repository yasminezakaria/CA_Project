module ALU( input [31:0] A,B, input [2:0]Sel, output [31:0] ALU_Out, output reg zeroFlag);

reg [31:0] Res;

assign ALU_Out = Res;


always @(*)
    begin
        case(Sel)
            3'b000: Res = A & B; 
            3'b001: Res = A + B; 
            3'b010: Res = A | B;
            3'b011: Res = A - B; 
            3'b100: Res = (A<B)?8'b00000001:8'b0000000;
        endcase
    end
    
always @(*)
    begin
    
    zeroFlag = (A==B)?1'b1:1'b0;
    
    end
endmodule

