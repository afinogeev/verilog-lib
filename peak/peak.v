// Finding peak value of signal

// afinogeev

module PEAK (
    input clk,
    input rst,
    input signed [DWIDTH-1:0] in,
    input signed [DWIDTH-1:0] out,
	output clk_l
);

parameter DWIDTH = 16;
parameter PERIOD = 6000;

reg signed [DWIDTH-1:0] peak_r;
assign out = peak_r;
reg signed [DWIDTH-1:0] peak_tmp;

wire peak_clk;
assign clk_l = peak_clk;
CLOCKER #( .FCLK(PERIOD), .FCLK_USR(1) ) peak_clocker(.clk(clk), .rst(rst), .clk_usr(peak_clk));

wire peak_clk_edg;
EDGER #( .TYPE(0) ) peak_clk_edger(.clk(clk), .rst(rst), .in(peak_clk), .out(peak_clk_edg));

always @(posedge clk or posedge rst) begin
	if(rst) begin
		peak_r <= 0;
		peak_tmp <= 0;
	end
	else begin
		if(in > peak_tmp)
			peak_tmp <= in; 

		if(peak_clk_edg) begin
			peak_r <= peak_tmp;
			peak_tmp <= 0;
		end
    end
end
    
endmodule