module Registerfile (clk,we3,wa3,ra1,ra2,wd3,rd1,rd2, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, SA, SB, SC, SD, SE, SF);

input [7:0]wd3;
input [3:0]wa3,ra1,ra2;
input  we3, clk;

output reg[7:0]rd1,rd2;
output reg[7:0]S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, SA, SB, SC, SD, SE, SF;

reg [7:0]registrador[15:0];

always@(posedge clk)
begin
if(we3==1)
registrador[wa3]<=wd3;
registrador[0]<=3'b00000000;

end
always@(*)
begin
rd1 <= registrador[ra1];
rd2 <= registrador[ra2];

S0 <= registrador[0];
S1 <= registrador[1];
S2 <= registrador[2];
S3 <= registrador[3];
S4 <= registrador[4];
S5 <= registrador[5];
S6 <= registrador[6];
S7 <= registrador[7];
S8 <= registrador[8];
S9 <= registrador[9];
SA <= registrador[10];
SB <= registrador[11];
SC <= registrador[12];
SD <= registrador[13];
SE <= registrador[14];
SF <= registrador[15];

end
endmodule
