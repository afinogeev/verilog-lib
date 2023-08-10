// Down rate

// afinogeev

module DRATE (
    input clk,
    input rst,
	input signed [FIR_TAPS*FIR_CWIDTH-1:0] fir_coefs,
    input signed [DWIDTH-1:0] in,
    output signed [DWIDTH-1:0] out,
	output clk_l
);

parameter DWIDTH = 16;
parameter F_H = 60;
parameter F_L = 3;
parameter FIR_CWIDTH = 16;
parameter FIR_TAPS = 64;
parameter FIR_SLICE = 37;

CLOCKER #(.FCLK(F_H), .FCLK_USR(F_L)) clocker(.clk(clk), .rst(rst), .clk_usr(clk_l));

wire signed [DWIDTH-1:0] fir_out;
FIR_NORM #( .TAPS(FIR_TAPS), .SLICE(FIR_SLICE) ) fir(
	.clk(clk),
	.coefs(fir_coefs),
	.in(in),
	.out(fir_out)
	);

SYNCH synch(.clk(clk_l), .rst(rst), .in(fir_out), .out(out));

endmodule