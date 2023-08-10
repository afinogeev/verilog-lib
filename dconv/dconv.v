// Downconverter

// afinogeev

module DCONV (
    input clk,
	input signed [FIR_TAPS*FIR_CWIDTH-1:0] fir_coefs,
    input signed [DWIDTH-1:0] rf,
    input signed [DWIDTH-1:0] lo,
    output signed [DWIDTH-1:0] out
);

parameter DWIDTH = 16;
parameter FIR_TAPS = 64;
parameter FIR_CWIDTH = 16;
parameter FIR_SLICE = 36;

wire signed [DWIDTH-1:0] mix_out;
MULT_NORM mix(.in1(rf), .in2(lo), .out(mix_out));

FIR_NORM #( .TAPS(FIR_TAPS), .SLICE(FIR_SLICE) ) fir(
	.clk(clk),
	.coefs(fir_coefs),
	.in(mix_out),
	.out(out)
	);

endmodule