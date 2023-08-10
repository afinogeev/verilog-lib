// Overwrite counter

// afinogeev

module COUNTER (
    input clk,
    input rst,
    input [DWIDTH-1:0] wr_data,
    input wr,
    output reg [DWIDTH-1:0] data
);

parameter DWIDTH = 8;

always @ (posedge clk or posedge rst)
   if (rst)
      data <= 0;
   else begin
      if(wr)
         data <= wr_data;
      else
         data <= data + 1;
   end

endmodule