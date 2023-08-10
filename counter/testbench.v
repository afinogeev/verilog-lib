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

reg [7:0] wr_data;
reg wr;
wire [7:0] out;
COUNTER cnt(clk, rst, wr_data, wr, out);

initial begin
    wr = 0;
    wr_data = 55;
	for(integer i = 0; i < 100; i++) begin
        $display("progress: %d %%", i);
        #100;
        if(i == 30)
            wr = 1;
        else
            wr = 0;
    end
	$finish;
end

endmodule