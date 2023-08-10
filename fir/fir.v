// marsohod.org

module FIR ( 
	input clk,
	input signed [IWIDTH-1:0] in,
	input signed [TAPS*CWIDTH-1:0] coefs, //all input coefficient concatineted
	output signed [RWIDTH-1:0] out //output takes only top bits part of result
 );

parameter IWIDTH  = 16;	//input data (signal) width
parameter CWIDTH = 16;	//tap coef data width (should be less then 32 bit)
parameter TAPS = 16;	//number of filter taps
localparam MWIDTH = (IWIDTH+CWIDTH); //multiplied width
localparam RWIDTH = (MWIDTH+TAPS-1); //filter result width

genvar i;
generate
	for( i=0; i<TAPS; i=i+1 )
	begin:tap
		//make tap register chain
		reg signed [IWIDTH-1:0] r=0;
		if(i==0)
		begin
			//1st tap takes signal from input
			always @(posedge clk)
				r <= in;
		end
		else
		begin
			//tap reg takes signal from prev tap reg
			always @(posedge clk)
				tap[i].r <= tap[i-1].r;
		end

		//get tap multiplication constant coef
		wire signed [CWIDTH-1:0] c;
		assign c = coefs[((TAPS-1-i)*CWIDTH+CWIDTH-1):(TAPS-1-i)*CWIDTH];

		//calculate multiplication and fix result in register
		reg signed [MWIDTH-1:0]m;
		always @(posedge clk)
			m <= r * c;
			
		//make combinatorial adders
		reg signed [MWIDTH-1+i:0]a;
		if(i==0)
		begin
			always @*
				tap[i].a = tap[i].m;
		end
		else
		begin
			always @*
				tap[i].a = tap[i].m + tap[i-1].a;
		end
	end
endgenerate

//fix calculated taps summa in register
reg signed [RWIDTH-1:0] result;
always @(posedge clk)
	result <= tap[TAPS-1].a;

//deliver output
assign out = result;

endmodule