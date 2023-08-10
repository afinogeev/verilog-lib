// Reset with delay

// afinogeev

module RESET (
	input clk,
	output rst
);

parameter DELAY = 10;

reg [$clog2(DWIDTH):0] cnt_rst = 0;
reg rst_r;
assign rst = rst_r

always @(posedge clk)
begin
	if (cnt_rst < 10) begin
		rst_r <= 1;
		cnt_rst <= cnt_rst + 1; 
	end
	else
		rst_r <= 0;
end

endmodule