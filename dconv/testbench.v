`timescale 10ns/1ns

`include "types.v"
`include "fir_lp_coefs.v"

module testbench();

reg clk;
reg rst;

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

`ws16_t lo;
SIN_LUT_20 lo_src(.clk(clk), .rst(rst), .out(lo));

`ws16_t rf;
SIN_LUT_21 rf_src(.clk(clk), .rst(rst), .out(rf));

`ws16_t out;
DCONV dconv(.clk(clk), .fir_coefs(`lp64_r12_coefs), .rf(rf), .lo(lo), .out(out));

initial
begin
    for(integer i = 0; i < 100; i++) begin
        $display("progress: %d %%", i);
        #100;
    end
	$finish;
end

endmodule