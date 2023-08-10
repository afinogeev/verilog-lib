`timescale 10ns/1ns

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

reg sig;
wire edg;
EDGER #( .TYPE(2) ) edger(.clk(clk), .rst(rst), .in(sig), .out(edg));

initial begin
    sig = 0;
	#100 sig = 1;
    #200 sig = 0;
    #300 sig = 1;
    #400 sig = 0;
    #100
	$finish;
end

endmodule