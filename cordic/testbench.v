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

`ws16_t cos, sin;
CORDIC_GEN_FREQ #( .FCLK(100000000) ) gen(.clk(clk), .rst(rst), .freq(5000000), .cos(cos), .sin(sin));

`ws16_t cos_step, sin_step;
CORDIC_GEN_STEP gen_step(.clk(clk), .rst(rst), .step(32'h0CCCCCCC), .cos(cos_step), .sin(sin_step));


initial begin
	for(integer i = 0; i < 100; i++) begin
        $display("progress: %d %%", i);
        #100;
    end
	$finish;
end

endmodule