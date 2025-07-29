`timescale 1ns/1ps

module scan_dff_mux (
    input  wire D,     // Normal data input
    input  wire SD,    // Scan data input
    input  wire SE,    // Scan enable (mux select)
    input  wire CLK,   // Clock
    input  wire RST,   // Asynchronous active-high reset
    output reg  Q      // Output
);

    wire mux_out;

    // 2:1 MUX: If SE == 1, select SD; else select D
    assign mux_out = SE ? SD : D;

    // Positive-edge triggered DFF with async reset
    always @(posedge CLK or posedge RST) begin
        if (RST)
            Q <= 1'b0;
        else
            Q <= mux_out;
    end

endmodule
