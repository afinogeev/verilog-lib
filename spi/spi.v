// SPI

// afinogeev

module SPI_SLAVE (
	input ss, 
	input sck,
	output miso,
	input mosi,
	input [DWIDTH-1:0] tx,
	output [DWIDTH-1:0] rx
);

parameter DWIDTH = 8;

reg [DWIDTH-1:0] rx_r;
assign rx = rx_r;

reg miso_r;
assign miso = miso_r;

reg [$clog2(DWIDTH):0] sck_cnt;

// RECEIVE
always @(posedge ss or posedge sck) begin
	if(ss)
		sck_cnt <= 0;
	else begin
		sck_cnt <= sck_cnt + 1;
		rx_r <= {rx_r[DWIDTH-2:0], mosi};
	end
end

// SEND
always @(negedge ss or negedge sck) begin
	if(sck_cnt < DWIDTH)
		miso_r <= tx[DWIDTH-1-sck_cnt];
end

endmodule

module SPI_MASTER (
	input clk,
	input rst,
	input start,
	output ss,
	output sck,
	input miso,
	output mosi,
	input [DWIDTH-1:0] tx,
	output [DWIDTH-1:0] rx
);

parameter DWIDTH = 8;
parameter FCLK = 100000000;
parameter BAUDRATE = 9600;

localparam CLK_SIZE = (FCLK/BAUDRATE)/2-1;

reg [DWIDTH-1:0] rx_r;
assign rx = rx_r;
reg mosi_r;
assign mosi = mosi_r;
reg ss_r;
assign ss = ss_r;

reg [$clog2(DWIDTH):0] sck_cnt = 0;
wire sck;
CLOCKER #( .FCLK(FCLK), .FCLK_USR(BAUDRATE)) sck_clocker(.clk(clk), .rst(ss), .clk_usr(sck));

reg [1:0] start_mem;
reg [1:0] sck_mem;
  
// CONTROL
always @(posedge rst or posedge clk) begin
	if(rst) begin
		ss_r <= 1;
		start_mem <= 0;
		sck_mem <= 0;
		sck_cnt <= 0;
	end
	else begin
		start_mem <= {start_mem[0], start};
		if(start_mem == 2'b01)
			ss_r <= 0;

		sck_mem <= {sck_mem[0], sck};
		if(sck_mem == 2'b01)
			sck_cnt <= sck_cnt + 1;
		if(sck_cnt >= DWIDTH && sck_mem == 2'b10) begin
			ss_r <= 1;
			sck_cnt <= 0;
		end
	end
end

// RECEIVE
always @(posedge sck) begin
	rx_r <= {rx[DWIDTH-2:0], miso};
end

// SEND
always @(negedge ss or negedge sck) begin
	if(sck_cnt < DWIDTH)
		mosi_r <= tx[DWIDTH-1-sck_cnt];
end
endmodule
