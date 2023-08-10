// Detect rising or falling edge of signal

// afinogeev

module EDGER (
	input clk,
	input rst,
	input in,
	output out
);

parameter TYPE = 0; // 0 - rise; 1 - fall; 2 - rise/fall

localparam edg = TYPE ? 2'b10 : 2'b01;

reg [1:0] sig_buf; 

reg out_r;
assign out = out_r;

always @(posedge rst or posedge clk) begin
	if(rst) begin
		sig_buf <= 0;
		out_r <= 0;
	end
	else begin
		out_r <= 0;
		sig_buf <= {sig_buf[0], in};

		if(TYPE == 2) begin
			if(sig_buf == 2'b01 || sig_buf == 2'b10)
				out_r <= 1;
		end
		else if(sig_buf == edg)
			out_r <= 1;
	end
end
	
endmodule
