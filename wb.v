module wb( select, in, o );

input select;
input[1:0] in;
output o;

wire o;
wire select;
wire[1:0] in;

assign o = in[select];

endmodule


module wb_tb;

reg[1:0] in;
reg select;
wire o;

integer  i;

wb w(select, in, o);

initial
begin
   #1 $monitor("in = %b", in, "  |  select = ", select, "  |  o = ", o );

   for( i = 0; i <= 3; i = i + 1)
   begin
      in = i;
      select = 0;  #1;
      select = 1;  #1;
      $display("-----------------------------------------");
    end

end
endmodule