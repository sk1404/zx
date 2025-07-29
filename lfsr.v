module lfsr(clk,rst,q);
input clk,rst;
output reg [3:0]q;
always @(posedge clk or negedge rst)
if(rst==0)
q<=4'b1101;
else
q<={q[2],q[1],q[0],q[0]^q[3]};
endmodule

module tb();
reg clk=1'b0;
reg rst;
wire [3:0]q;
lfsr uut(clk,rst,q);
always #5 clk=~clk;
initial
begin
rst=0;
#10;
rst=1;
#200 $finish;
end
endmodule
