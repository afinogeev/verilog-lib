// Sin table

// afinogeev

module SIN_LUT_15 (
    input clk,
    input rst,
    output signed [15:0] out
);

localparam size = 14;

reg [4:0] cnt;

wire signed [15:0] tbl [0:size];
assign tbl[00] = $signed(0     );
assign tbl[01] = $signed(14217 );
assign tbl[02] = $signed(25619 );
assign tbl[03] = $signed(31946 );
assign tbl[04] = $signed(31946 );
assign tbl[05] = $signed(25619 );
assign tbl[06] = $signed(14217 );
assign tbl[07] = $signed(0     );
assign tbl[08] = $signed(-14217);
assign tbl[09] = $signed(-25619);
assign tbl[10] = $signed(-31946);
assign tbl[11] = $signed(-31946);
assign tbl[12] = $signed(-25619);
assign tbl[13] = $signed(-14217);
assign tbl[14] = $signed(0     );

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