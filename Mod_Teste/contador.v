module contador(input clk,clr,output [2:0]q);

JK u0(1'b1,1'b1,clr,clk,q[0]);
JK u1(1'b1,1'b1,clr,q[0],q[1]);
JK u2(1'b1,1'b1,clr,q[1],q[2]);


endmodule 

