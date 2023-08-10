// Sin table

// afinogeev

module SIN_LUT_10 (
    input clk,
    input rst,
    output signed [15:0] out
);

localparam size = 9;

reg [4:0] cnt;

wire signed [15:0] tbl [0:size];
assign tbl[00] = $signed(0     );
assign tbl[01] = $signed(21063 );
assign tbl[02] = $signed(32270 );
assign tbl[03] = $signed(28378 );
assign tbl[04] = $signed(11207 );
assign tbl[05] = $signed(-11207);
assign tbl[06] = $signed(-28378);
assign tbl[07] = $signed(-32270);
assign tbl[08] = $signed(-21063);
assign tbl[09] = $signed(0     );

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