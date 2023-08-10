`timescale 10ns/1ns

`include "types.v"

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

initial
begin
    for(integer i = 0; i < 100; i++) begin
        $display("progress: %d %%", i);
        #200;
    end
	$finish;
end


wire clk_l;
CLOCKER #(.FCLK(60), .FCLK_USR(3)) clocker(.clk(clk), .rst(rst), .clk_usr(clk_l));

`ws16_t sin;
SIN_LUT_20 sin_lut_20(.clk(clk_l), .rst(rst), .out(sin));

`ws16_t out;
URATE #( .F_H(60), .F_L(3) ) urate(.clk(clk), .rst(rst), .in(sin), .out(out));

endmodule