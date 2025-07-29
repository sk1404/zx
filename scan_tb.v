module tb_scan_dff_mux;

    // Inputs
    reg D;
    reg SD;
    reg SE;
    reg CLK;
    reg RST;

    // Output
    wire Q;

    // Instantiate the Unit Under Test (UUT)
    scan_dff_mux uut (
        .D(D),
        .SD(SD),
        .SE(SE),
        .CLK(CLK),
        .RST(RST),
        .Q(Q)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK; // 10ns clock period
    end

    // Stimulus
    initial begin
        // Initialize inputs
        D = 0;
        SD = 0;
        SE = 0;
        RST = 1;

        // Hold reset high for a bit
        #10 RST = 0;

        // Apply test vectors
        #10 D = 1; SE = 0; // Expect Q to follow D
        #10 D = 0;

        #10 SE = 1; SD = 1; // Expect Q to follow SD
        #10 SD = 0;

        #10 RST = 1; // Check asynchronous reset
        #5  RST = 0;

        #20 $finish;
    end

endmodule
