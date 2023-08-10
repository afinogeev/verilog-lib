// Synchronize input data

// afinogeev

module SYNCH (
    input clk,
	input rst,
    input signed [DWIDTH-1:0] in,
    output signed [DWIDTH-1:0] out
);

parameter DWIDTH = 16;

reg signed [DWIDTH-1:0] data;
assign out = data;

always @(posedge clk or posedge rst) begin
	if(rst)
		data <= 0;
	else
		data <= in;	
end

endmodule