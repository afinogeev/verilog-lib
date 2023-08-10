// Up rate

// afinogeev

`include "fir_lp_coefs.v"

module URATE (
    input clk,
    input rst,
    input signed [DWIDTH-1:0] in,
    output signed [DWIDTH-1:0] out
);

parameter DWIDTH = 16;
parameter F_H = 60;
parameter F_L = 3;
parameter FIR_TAPS = 64;
parameter FIR_SLICE = 32;

localparam RATE = F_H/F_L;

reg [7:0] cnt;
reg signed [DWIDTH-1:0] buff;
always @(posedge clk or posedge rst) begin
	if(rst) begin
		cnt <= 0;
		buff <= 0;
	end
	else begin
		cnt <= cnt + 1;
		if(cnt >= RATE-1) begin
			cnt <= 0;
			buff <= in;
		end
		else 
			buff <= 0;
	end	
end

wire signed [DWIDTH-1:0] fir_out;
FIR_NORM #( .TAPS(FIR_TAPS), .SLICE(FIR_SLICE) ) fir(
	.clk(clk),
	.coefs( `lp64_r12_coefs ),
	.in(buff),
	.out(out)
	);

endmodule