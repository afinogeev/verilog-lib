`timescale 1us/1ns

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

reg enable;
wire done;
TIMER #( .FCLK(1000000), .SCALE(1000) ) timer(.clk(clk), .rst(rst), .enbl(enable), .done(done), .value(20));

initial begin
    enable = 0;
	for(integer i = 0; i < 100; i++) begin
        $display("progress: %d %%", i);
        #1000;
        if(i > 10 && i < 90)
            enable = 1;
        else
            enable = 0;
    end
	$finish;
end

endmodule