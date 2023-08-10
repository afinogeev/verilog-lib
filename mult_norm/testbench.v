`timescale 10ns/1ns

module testbench ();
  
reg clk;
reg rst;

reg signed [15:0] in1;
reg signed [15:0] in2;
wire signed [15:0] out;

MULT_NORM mult(.in1(in1), .in2(in2), .out(out));

task automatic generate_value;
begin
	in1 += 100;
	in2 += 1000;
end
endtask

initial begin
	$dumpfile("out.vcd");
	$dumpvars(0,testbench);
	clk = 0;
	#0.5 forever #0.5 clk = !clk;
end

initial begin
    rst = 1;
    repeat (10) @(posedge clk);
    rst = 0;
end

initial begin
	in1 = 0;
	in2 = 0;
	for(integer i = 0; i < 400; i++) begin
		generate_value;
		#1;
	end

	$finish;
end

endmodule