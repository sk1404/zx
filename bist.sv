module LFSR ( input logic clk, rst, output logic [2:0] q);
 always_ff @(posedge clk or posedge rst)
 begin
 if (rst) q <= 3'b111; // Load seed value on reset
 else q <= {q[1], q[0], q[1] ^ q[2]}; // Shift register and apply feedback
 end
endmodule

module FullAdd (input logic a,b,c, output logic s,co);
 assign {co, s} = a + b + c;
endmodule

module SignatureAnalyser (input logic clk, rst, in, output logic [3:0] sign);
logic [3:0]q;
 always_ff @(posedge clk or posedge rst)
 begin
 if (rst) q <= 4'b0001; // Load seed value on reset
 else q <= {q[2], q[1], q[0], q[2] ^ in}; // Shift register and apply

 end
 assign sign=q;
endmodule


module BIST (input logic clk, input logic rst, output logic [3:0] signature);
logic [2:0] in;
logic sum,cout;
 LFSR lfsr1 ( clk,rst,in );
 FullAdd fa1 ( in[0],in[1],in[2],sum,cout);
 SignatureAnalyser sa1 ( clk,rst,sum,signature );
endmodule
