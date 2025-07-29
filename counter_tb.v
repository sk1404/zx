module basic_tb();
reg a,b,c,e;
wire l;
basic uut(a,b,c,e,l);
initial begin

a=1'b1; b=1'b1; c=1'b1; e=1'b1; #10;
a=1'b0; b=1'b1; c=1'b1; e=1'b1; #10;
a=1'b1; b=1'b1; c=1'b0; e=1'b1; #10;
a=1'b1; b=1'b0; c=1'b1; e=1'b1; #10;
a=1'b0; b=1'b0; c=1'b1; e=1'b1; #10;
a=1'b1; b=1'b0; c=1'b0; e=1'b1; #10;

end
endmodule
