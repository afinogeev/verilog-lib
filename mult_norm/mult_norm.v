// Multiplication normalized

// afinogeev

module MULT_NORM(
    input signed [DWIDTH-1:0] in1,
    input signed [DWIDTH-1:0] in2,
    output signed [DWIDTH-1:0] out
);

parameter DWIDTH = 16;

wire signed [2*DWIDTH-1:0] prod = in1 * in2;
assign out = prod[2*DWIDTH-2:DWIDTH-1];

endmodule