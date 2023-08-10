// Timer

// afinogeev

module TIMER (
	input clk,
	input rst,
	input enbl,
	output wire done,
	input wire [31:0] value
);


parameter FCLK = 100000000;
parameter SCALE = 1000; // 1 - s, 1000 - ms, 1000000 - us

localparam period = FCLK/SCALE;

reg [31:0] cnt_clk;
reg [31:0] cnt_time;

reg done_r;
assign done = done_r;

always @(posedge clk or posedge rst) begin
	if(rst) begin
		cnt_clk <= 0;
		cnt_time <= 0;
		done_r <= 0;
	end
	else begin
		if(enbl)
		begin
			cnt_clk <= cnt_clk + 1;
			if(cnt_clk >= period - 1) begin
				cnt_time <= cnt_time + 1;
				cnt_clk <= 0;
			end

			if(cnt_time >= value) begin
				done_r <= 1;
				cnt_time <= 0;
			end
			else
				done_r <= 0;
		end
		else begin
			cnt_clk <= 0;
			cnt_time <= 0;
			done_r <= 0;
		end
			
	end
end

endmodule
