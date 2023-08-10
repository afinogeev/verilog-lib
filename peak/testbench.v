`timescale 10ns/1ns

`include "types.v"

module testbench ();
  
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

`rs16_t sig;
`ws16_t out;
PEAK #( .PERIOD(3000) ) peak(.clk(clk), .rst(rst), .in(sig), .out(out));

initial begin
    sig = 0;
	for(integer i = 0; i < 100; i++) begin
        $display("progress: %d %%", i);
        #100;
        sig = sig + 100;
    end
	$finish;
end

endmodule