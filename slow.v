module SDFF(output reg q,input D,SI,SE,clk,rst);
wire SD;
mux_2to1 mux(SD,D,SI,SE);
always @(posedge clk or posedge rst)
if (rst == 1)
q<=0;
else
q<=SD;
endmodule

module mux_2to1 (output out, input a,b,sel);
assign out=sel?b:a;
endmodule


//module dff (CK,Q,D);

module s27(CK,G0,G1,G17,G2,G3,SI,SE,rst);
input CK,G0,G1,G2,G3,SI,SE,rst;
output G17;
  wire G5,G10,G6,G11,G7,G13,G14,G8,G15,G12,G16,G9;
  SDFF DFF_0(G5,G10,SI,SE,CK,rst);
  SDFF DFF_1(G6,G11,G5,SE,CK,rst);
  //SDFF DFF_1(CK,G6,G11);
  SDFF DFF_2(G7,G13,G6,SE,CK,rst);
  //SDFF DFF_2(CK,G7,G13);
  not NOT_0(G14,G0);
  not NOT_1(G17,G11);
  and AND2_0(G8,G14,G6);
  or OR2_0(G15,G12,G8);
  or OR2_1(G16,G3,G8);
  nand NAND2_0(G9,G16,G15);
  nor NOR2_0(G10,G14,G11);
  nor NOR2_1(G11,G5,G9);
  nor NOR2_2(G12,G1,G7);
  nor NOR2_3(G13,G2,G12);
endmodule


module s27_tb;

  reg clk;
  reg reset;
  reg scan_in;
  reg scan_enable;
  reg G0, G1, G2, G3;
  wire G17;

  // Instantiate the DUT
  s27 uut (.CK(clk), .G0(G0), .G1(G1), .G2(G2), .G3(G3), .SI(scan_in), .SE(scan_enable), .rst(reset), .G17(G17));

  // Clock generation: 10ns period
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Scan test sequence
  initial begin
    // Initialize
    reset = 1;
    scan_enable = 0;
    scan_in = 0;
    G0 = 0; G1 = 0; G2 = 0; G3 = 0;

    // Reset for a cycle
    #10;
    reset = 0;

    // === Scan-In Phase (shifting in 3 bits: 1, 0, 1) ===
    scan_enable = 1;
    scan_in = 1; #10;
    scan_in = 0; #10;
    scan_in = 1; #10;

    // === Functional Mode (capture) ===
    scan_enable = 0;
    G0 = 1; G1 = 1; G2 = 0; G3 = 1;
    #10;

    // === Scan-Out Phase ===
    scan_enable = 1;
    scan_in = 0; #10; // shift dummy to read out G7
    scan_in = 0; #10; // shift dummy to read out G6
    scan_in = 0; #10; // shift dummy to read out G5

    #20;
    $finish;
  end

  // Output monitor
  initial begin
    $monitor("Time=%0t | clk=%b | rst=%b | SE=%b | SI=%b | G5=%b G6=%b G7=%b | G17=%b",
              $time, clk, reset, scan_enable, scan_in, uut.G5, uut.G6, uut.G7, G17);
  end

endmodule


