// Random value

// afinogeev

module RANDOM (
	input clk,
	input rst,
	output [DWIDTH-1:0] out
);

parameter DWIDTH = 16;
parameter INIT_REG = 32'h974CA351;


reg [31:0] rand;
assign out = rand;

always @(posedge clk or posedge rst) begin
	if(rst) 
		rand <= INIT_REG;
	else 
		rand <= { rand[30:0], ~rand[31] };
		rand[25] <= ~rand[3];
		rand[20] <= ~rand[13];
		rand[15] <= ~rand[23];
		rand[10] <= ~rand[26];
		rand[05] <= ~rand[29];
		rand[30] <= rand[24] ^ rand[19] ^ rand[3];
		rand[29] <= rand[23] ^ rand[17] ^ rand[7] ^ rand[6];
end

endmodule
