//LFSR
module LFSR (input clk, input rst, output reg [2:0] q);
  always @(posedge clk or posedge rst) begin
    if (rst)
      q <= 3'b111; // Load seed value on reset
    else
      q <= {q[1], q[0], q[1] ^ q[2]}; // Feedback and shift
  end
endmodule

//CUT
module FullAdd (input a, b, c, output reg s, co);
  always @(*) begin
    {co, s} = a + b + c;
  end
endmodule

//Signature Analyzer
module SignatureAnalyser (input clk, rst, in, output reg [3:0] sign);
  always @(posedge clk or posedge rst) begin
    if (rst)
      sign <= 4'b0001;  // Load seed value
    else
      sign <= {sign[2], sign[1], sign[0], sign[2] ^ in};
  end
endmodule

//Top Module
module BIST (input clk, input rst, output [3:0] signature);
  wire [2:0] in;
  wire sum, cout;

  LFSR lfsr1 (.clk(clk), .rst(rst), .q(in));
  FullAdd fa1 (.a(in[0]), .b(in[1]), .c(in[2]), .s(sum), .co(cout));
  SignatureAnalyser sa1 (.clk(clk), .rst(rst), .in(sum), .sign(signature));

endmodule

