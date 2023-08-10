// Sin table

// afinogeev

module SIN_LUT_20 (
    input clk,
    input rst,
    output signed [15:0] out
);

localparam size = 19;

reg [4:0] cnt;

wire signed [15:0] tbl [0:size];
assign tbl[00] = $signed(0     );
assign tbl[01] = $signed(10639 );
assign tbl[02] = $signed(20126 );
assign tbl[03] = $signed(27432 );
assign tbl[04] = $signed(31765 );
assign tbl[05] = $signed(32656 );
assign tbl[06] = $signed(30008 );
assign tbl[07] = $signed(24108 );
assign tbl[08] = $signed(15595 );
assign tbl[09] = $signed(5393  );
assign tbl[10] = $signed(-5393 );
assign tbl[11] = $signed(-15595);
assign tbl[12] = $signed(-24108);
assign tbl[13] = $signed(-30008);
assign tbl[14] = $signed(-32656);
assign tbl[15] = $signed(-31765);
assign tbl[16] = $signed(-27432);
assign tbl[17] = $signed(-20126);
assign tbl[18] = $signed(-10639);
assign tbl[19] = $signed(0     );

assign out = tbl[cnt];

always @(posedge clk or posedge rst) begin
    if(rst) begin
        cnt <= 0;
    end
    else begin
        if(cnt == size)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end
end

endmodule