module tb_BIST;
  // Testbench signals
  reg clk;
  reg rst;
  wire [3:0] signature;

  // Instantiate the BIST module
  BIST uut (.clk(clk), .rst(rst), .signature(signature));

  // Clock generation
  always begin
    #5 clk = ~clk;  // Toggle clock every 5 time units
  end

  // Test sequence
  initial begin
    // Initialize signals
    clk = 0;
    rst = 0;

    // Apply reset
    rst = 1;
    #10;
    rst = 0;
    // Wait and observe the system
    #100;
    // Apply another reset
    rst = 1;
    #10;
    rst = 0;
    // Run for additional time to observe behavior
    #100;

    // Finish simulation
    $finish;
  end

  // Monitor outputs
  initial begin
    $monitor("Time = %0t | rst = %b | signature = %b", $time, rst, signature);
  end

endmodule
