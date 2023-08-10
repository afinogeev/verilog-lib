// Sin table

// afinogeev

module SIN_LUT_21 (
    input clk,
    input rst,
    output signed [15:0] out
);

localparam size = 20;

reg [4:0] cnt;

wire signed [15:0] tbl [0:size];
assign tbl[00] = $signed(0     );
assign tbl[01] = $signed(10125 );
assign tbl[02] = $signed(19260 );
assign tbl[03] = $signed(26509 );
assign tbl[04] = $signed(31164 );
assign tbl[05] = $signed(32767 );
assign tbl[06] = $signed(31164 );
assign tbl[07] = $signed(26509 );
assign tbl[08] = $signed(19260 );
assign tbl[09] = $signed(10125 );
assign tbl[10] = $signed(0     );
assign tbl[11] = $signed(-10125);
assign tbl[12] = $signed(-19260);
assign tbl[13] = $signed(-26509);
assign tbl[14] = $signed(-31164);
assign tbl[15] = $signed(-32767);
assign tbl[16] = $signed(-31164);
assign tbl[17] = $signed(-26509);
assign tbl[18] = $signed(-19260);
assign tbl[19] = $signed(-10125);
assign tbl[20] = $signed(0     );

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