module testbench_s27;
  reg CK;
  reg G0, G1, G2, G3,VDD,GND;
  wire G17;

  s27 dut (.CK(CK), .G0(G0), .G1(G1), .G2(G2), .G3(G3), .G17(G17));

  // Clock generation
  initial begin
    CK = 0;
    forever #5 CK = ~CK; // 10ns clock period
  end

  // Stimulus
  initial begin
    // Initialize power and inputs
    GND = 0;
    VDD = 1;
    G0 = 0; G1 = 0; G2 = 0; G3 = 0;

    // Apply input patterns
    #10 G0 = 1;
    #10 G1 = 1;
    #10 G2 = 1;
    #10 G3 = 1;
    #10 G0 = 0; G1 = 1; G2 = 0; G3 = 1;
    #10 G0 = 1; G1 = 0; G2 = 1; G3 = 0;

     #50;
    $finish;
  end
endmodule

