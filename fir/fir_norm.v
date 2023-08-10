// FIR normalized

// afinogeev

module FIR_NORM (
    input clk,
    input rst,
    input signed [TAPS*CWIDTH-1:0] coefs,
    input signed [DWIDTH-1:0] in,
    output signed [DWIDTH-1:0] out
);

parameter DWIDTH = 16;
parameter TAPS = 64;
parameter CWIDTH = 16;
parameter SLICE = 36;

wire signed [SLICE:0] fir_out;
assign out = fir_out[SLICE:SLICE-DWIDTH-1];
FIR #( .TAPS(TAPS), .IWIDTH(DWIDTH) ) fir(
	.clk(clk),
	.coefs(coefs),
	.in(in),
	.out(fir_out)
	);

endmodule