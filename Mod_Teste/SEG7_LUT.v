module SEG7_LUT(oSEG, iDIG);
	input[3:0] iDIG;
	output reg[6:0] oSEG;

	
	always@(iDIG)begin
	
		case({iDIG})
			4'h0: oSEG =  7'b1000000;
			4'h1: oSEG = ~7'b0000110;
			4'h2: oSEG =  7'b1001101;
			4'h3: oSEG =  7'b1001111;
			4'h4: oSEG =  7'b1100110;
			4'h5: oSEG =  7'b1101101;
			4'h6: oSEG = ~7'b0000010;
			4'h7: oSEG =  7'b0000111;
			4'h8: oSEG = ~7'b0000000;
			4'h9: oSEG = ~7'b0010000;
			4'ha: oSEG = ~7'b0001000;
			4'hb: oSEG = ~7'b0000010;
			4'hc: oSEG = ~7'b1000110;
			4'hd: oSEG = ~7'b0100000;
			4'he: oSEG = ~7'b0000110;
			4'hf: oSEG = ~7'b0001110;
			
			endcase
end
endmodule
