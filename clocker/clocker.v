// Clock frequency

// afinogeev

module CLOCKER (
	input clk,
	input rst,
	output clk_usr
);

parameter FCLK = 100000000;
parameter FCLK_USR = 9600;

localparam SIZE = FCLK/FCLK_USR/2;

reg clk_usr_r;
assign clk_usr = clk_usr_r;
reg [31:0] cnt;

always @(posedge rst or posedge clk) begin
	if(rst) begin
		cnt <= 0;
		clk_usr_r <= 0;
	end
	else begin
		cnt <= cnt + 1;
		if(cnt >= SIZE-1) begin
			cnt <= 0;
			clk_usr_r <= ~clk_usr_r;
		end
	end
end
	
endmodule
