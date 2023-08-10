`timescale 10ns/1ns

module testbench ();
  
reg clk;
reg rst;

wire signed [15:0] sin_21;
wire signed [15:0] sin_20;
wire signed [15:0] sin_15;
wire signed [15:0] sin_12;

SIN_LUT_21 sin_lut_21(clk, rst, sin_21);
SIN_LUT_20 sin_lut_20(clk, rst, sin_20);
SIN_LUT_15 sin_lut_15(clk, rst, sin_15);
SIN_LUT_12 sin_lut_12(clk, rst, sin_12);

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

initial
begin
    for(integer i = 0; i < 100; i++) begin
        $display("progress: %d %%", i);
        #100;
    end
	$finish;
end

endmodule