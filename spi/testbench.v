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

reg start;
wire ss;
wire sck;
wire miso;
wire mosi;
reg [7:0] m_tx;
wire [7:0] m_rx;
SPI_MASTER #( .FCLK(100000000), .BAUDRATE(9600) ) spi_m(.clk(clk), .rst(rst), .start(start), .ss(ss), .sck(sck), .miso(miso), .mosi(mosi), .tx(m_tx), .rx(m_rx));

reg [7:0] s_tx;
wire [7:0] s_rx;
SPI_SLAVE spi_s(.ss(ss), .sck(sck), .miso(miso), .mosi(mosi), .tx(s_tx), .rx(s_rx));

task automatic word_transmit (
    input [7:0] data
);
begin
    m_tx = data;
    s_tx = data + 5;
    start = 1;
    #10
    start = 0;
end
endtask

initial begin
    start = 0;
	for(integer i = 0; i < 10; i++) begin
        word_transmit(i);
        #200000;
    end
	$finish;
end

endmodule