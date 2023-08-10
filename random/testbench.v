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

initial begin
	for(integer i = 0; i < 100; i++) begin
        $display("progress: %d %%", i);
        #100;
    end
	$finish;
end

wire prs_out;
PRS prs(.clk(clk), .rst(rst), .out(prs_out));

wire [15:0] rand_out;
RANDOM rand(.clk(clk), .rst(rst), .out(rand_out));

endmodule