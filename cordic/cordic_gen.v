// Cordic generator

// afinogeev

module CORDIC_GEN_STEP(
	input clk,
	input rst,
	input [31:0] step, 
	output signed [DWIDTH-1:0] cos,
	output signed [DWIDTH-1:0] sin
);
    
parameter DWIDTH = 16;

localparam [31:0] SHIFT = 32'h00000001 << (DWIDTH-1);
localparam [31:0] COEF = (SHIFT-(DWIDTH-1)/2)/1.647; //(1.647 = 1/0.607 ; 0.607 is K)

reg signed [DWIDTH-1:0] x_start, y_start;
reg [32:0] angle; 

CORDIC #( .DWIDTH(DWIDTH) ) cordic(.clk(clk), .rst(rst), .x_start(x_start), .y_start(y_start), .angle(angle), .cos(cos), .sin(sin));

always @(posedge clk or posedge rst) begin
	if(rst) begin
		angle <= 0;
		x_start <= COEF;
		y_start <= 0;
	end
	else if(clk)
		if(angle + step >= 32'hFFFFFFFF) 
			angle <= angle + step - 32'hFFFFFFFF;
		else 
			angle <= angle + step;
end  

endmodule

module CORDIC_GEN_FREQ(
	input clk,
	input rst,
	input [31:0] freq, 
	output signed [DWIDTH-1:0] cos,
	output signed [DWIDTH-1:0] sin
);
    
parameter DWIDTH = 16;
parameter FCLK = 100000000;

localparam [31:0] SHIFT = 32'h00000001 << (DWIDTH-1);
localparam [31:0] COEF = (SHIFT-(DWIDTH-1)/2)/1.647; //(1.647 = 1/0.607 ; 0.607 is K)
localparam [31:0] STEP_COEF = 64'hFFFFFFFF/FCLK;

reg signed [DWIDTH-1:0] x_start, y_start;
reg [32:0] angle; 
reg [32:0] step;

CORDIC #( .DWIDTH(DWIDTH) ) cordic(.clk(clk), .rst(rst), .x_start(x_start), .y_start(y_start), .angle(angle), .cos(cos), .sin(sin));

always @(posedge clk)
	step <= freq*STEP_COEF;

always @(posedge clk or posedge rst) begin
	if(rst) begin
		angle <= 0;
		x_start <= COEF;
		y_start <= 0;
	end
	else if(clk)
		if(angle + step >= 32'hFFFFFFFF) 
			angle <= angle + step - 32'hFFFFFFFF;
		else 
			angle <= angle + step;
end  

endmodule

