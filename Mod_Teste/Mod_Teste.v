module Mod_Teste (//adaptado por Danilo G.
 //////////////////// Fonte de Clock ////////////////////
		 CLOCK_27,    // 27 MHz
		 CLOCK_50,    // 50 MHz
		 //////////////////// Push Button    ////////////////////
		 KEY,         // Pushbutton (botoes) [3:0]
		 //////////////////// Chaves DPDT
		 SW,         // Toggle Switch (chaves) [17:0]
		 /////////////////// Display de 7-SEG ///////////////////
		 HEX0,       // Display 0
		 HEX1,       // Display 1
		 HEX2,       // Display 2
		 HEX3,       // Display 3
		 HEX4,       // Display 4
		 HEX5,       // Display 5
		 HEX6,       // Display 6
		 HEX7,       // Display 7
		 /////////////////// LED //////////////////
		 LEDG,       // LED Green (verde) [8:0]
		 LEDR,       // LED Red (vermelho) [17:0]
		 ////////////////////	LCD Module 16X2		////////////////
		 LCD_ON,							//	LCD Power ON/OFF
		 LCD_BLON,						//	LCD Back Light ON/OFF
		 LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
	    LCD_EN,							//	LCD Enable
		 LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		 LCD_DATA,						//	LCD Data bus 8 bits
		 GPIO_0,							// GPIO
		 GPIO_1,			
	);


   input CLOCK_27;
   input CLOCK_50;

   input [3:0] KEY;
   input [17:0] SW;

   output [6:0] HEX0;
   output [6:0] HEX1;
   output [6:0] HEX2;
   output [6:0] HEX3;
   output [6:0] HEX4;
   output [6:0] HEX5;
	output [6:0] HEX6;
	output [6:0] HEX7;
	
	output [8:0] LEDG;
	output [17:0] LEDR;


// Parte 2
	////////////////////	LCD Module 16X2	////////////////////////////
	inout	[7:0]		LCD_DATA;				//	LCD Data bus 8 bits
	output			LCD_ON;					//	LCD Power ON/OFF
	output			LCD_BLON;				//	LCD Back Light ON/OFF
	output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
	output			LCD_EN;					//	LCD Enable
	output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////////	GPIO	////////////////////////////////
	inout	[35:0]	GPIO_0;					//	GPIO Connection 0
	inout	[35:0]	GPIO_1;					//	GPIO Connection 1
////////////////////////////////////////////////////////////////////

//	All inout port turn to tri-state	
	assign	GPIO_1		=	36'hzzzzzzzzz;
	assign	GPIO_0		=	36'hzzzzzzzzz;	
	
	//	LCD 
	assign	LCD_ON		=	1'b1;
	assign	LCD_BLON		=	1'b1;
	
	LCD_TEST 			u5	(	
	
							//	Host Side
							.iCLK  	( CLOCK_50 ),
							.iRST_N	( KEY[0] ),
							
							.d000 (d000),		//		P		
							.d001 (d001),		//		r		
							.d002 (d002),		//		i		
							.d003 (d003),		//		m		
							.d004 (d004),		//		e		
							.d005 (d005),		//		i		
							.d006 (d006),		//		r		
							.d007 (d007),		//		a		
							.d008 (d008),		//		 		
							.d009 (d009),		//		L		
							.d010 (d010),		//		i		
							.d011 (d011),		//		n		
							.d012 (d012),		//		h		
							.d013 (d013),		//		a		
							.d014 (d014),		//		!		
							.d015 (d015),		//		 		
							
							.d100 (d100),		//		~	
							.d101 (d101),		//		S		
							.d102 (d102),		//		e		
							.d103 (d103),		//		g		
							.d104 (d104),		//		u		
							.d105 (d105),		//		n		
							.d106 (d106),		//		d		
							.d107 (d107),		//		a		
							.d108 (d108),		//				
							.d109 (d109),		//		L		
							.d110 (d110),		//		i		
							.d111 (d111),		//		n	
							.d112 (d112),		//		h		
							.d113 (d113),		//		a		
							.d114 (d114),		//		!		
							.d115 (d115),		//		 		
							
							//	LCD Side
							
							.LCD_DATA( LCD_DATA ),
							.LCD_RW  ( LCD_RW ),
							.LCD_EN	( LCD_EN ),
							.LCD_RS  ( LCD_RS )	
							);
							
							
							
							
	wire [7:0] d000,d001,d002,d003,d004,d005,d006,d007,d008,d009,d010,d011,d012,d013,d014,d015,d100,d101,d102,d103,d104,d105,d106,d107,d108,d109,d110,d111,d112,d113,d114,d115;
	

//parte mod ----------------------------------------------------------------------

wire w_PCSrc, w_Jump, w_Branch, w_Z, CLK, w_ULASrc, w_RegWrite, w_RegDst, w_MemtoReg, w_MemWrite, w_We;
wire [3:0]w_wa3;
wire [7:0]w_PCp1, w_m1, w_nPC, w_PCBranch, w_PC, w_rd1SrcA, w_rd2, w_SrcB, w_ULAResultWd3, w_wd3, w_RData, saida_and_1, saida_and_2, w_DataIn, w_DataOut, w_RegData;
wire [31:0]w_Inst;
wire [2:0]w_ULAControl;
wire [7:0]lcd_reg[15:0];

assign w_DataIn = SW[7:0];
assign LEDR[7:0] = w_DataIn;
assign reset = KEY[0];

assign HEX0[0] = w_DataOut[0];
assign HEX0[1] = w_DataOut[1];
assign HEX0[2] = w_DataOut[2];
assign HEX0[3] = w_DataOut[3];
assign HEX0[4] = w_DataOut[4];
assign HEX0[5] = w_DataOut[5];
assign HEX0[6] = w_DataOut[6];


clock_divisor(.CLK_entrada(CLOCK_50), .CLK_saida(CLK));

PC (.clk(CLK), .PCin(w_nPC), .PCout(w_PC));

somador1 som1(.A(w_PC), .B(1'b1), .C(w_PCp1));


Registerfile(.clk(CLK),.we3(w_RegWrite),.wa3(w_wa3),.ra1(w_Inst[25:21]),.ra2(w_Inst[20:16]),.wd3(w_wd3),.rd1(w_rd1SrcA),.rd2(w_rd2), 
.S0(lcd_reg[0]), .S1(lcd_reg[1]), .S2(lcd_reg[2]), .S3(lcd_reg[3]), .S4(lcd_reg[4]), .S5(lcd_reg[5]), .S6(lcd_reg[6]), .S7(lcd_reg[7]), 
.S8(lcd_reg[8]), .S9(lcd_reg[9]), .SA(lcd_reg[10]), .SB(lcd_reg[11]), .SC(lcd_reg[12]), .SD(lcd_reg[13]), .SE(lcd_reg[14]), .SF(lcd_reg[15]));

Mux2_1 muxULA(.entrada1(w_Inst[7:0]),.entrada2(w_rd2),.ch(w_ULASrc),.saida(w_SrcB));

Mux2_1 muxWR(.entrada1(w_Inst[15:11]),.entrada2(w_Inst[20:16]),.ch(w_RegDst),.saida(w_wa3));

ControlUnit(.OP(w_Inst[31:26]), .Funct(w_Inst[5:0]), .Jump(w_Jump), .MemtoReg(w_MemtoReg), .MemWrite(w_MemWrite), 
.Branch(w_Branch), .ULASrc(w_ULASrc), .RegDst(w_RegDst), .RegWrite(w_RegWrite), .ULAControl(w_ULAControl[2:0]));

ULA(.SrcA(w_rd1SrcA),.SrcB(w_SrcB),.ULAControl(w_ULAControl[2:0]),.ULAResult(w_ULAResultWd3),.FlagZ(w_Z));

RamDataMem ( .address(w_ULAResultWd3), .clock(CLOCK_50), .data(w_rd2), .wren(w_We), .q(w_RData));
RomInstMem ( .address(w_PC), .clock(CLOCK_50), .q(w_Inst));
Mux2_1 MuxDDest(.entrada1(w_RegData), .entrada2(w_ULAResultWd3),.ch(w_MemtoReg),.saida(w_wd3));

Mux2_1 MuxPCSrc( .entrada1(w_PCBranch), .entrada2(w_PCp1), .ch(w_PCSrc), .saida(w_m1));
Mux2_1 MuxJump( .entrada1(w_Inst[7:0]), .entrada2(w_m1), .ch(w_Jump), .saida(w_nPC));
Module_AND and1( .ent1(w_Branch), .ent2(w_Z), .saida(saida_and_1));

assign w_PCSrc = saida_and_1;

somador1 som2( .A(w_PCp1), .B(w_Inst[7:0]), .C(w_PCBranch));

Parallel_IN (.MemData(w_RData), .Address(w_ULAResultWd3), .DataIn(w_DataIn), .RegData(w_RegData));
Parallel_OUT (.Address(w_ULAResultWd3), .we(w_MemWrite), .RegData(w_rd2), .DataOut(w_DataOut), .wren(w_We), .clk(CLK));

//Configura as linhas  do Display LCD convertendo os valores para código ASCII:

	//Linha superior
	assign d000 = 80;	// P	
	assign d001 = 76;	//	L
	assign d002 = 65;	// A		
	assign d003 = 89;	//	Y	
	assign d004 = 69;	// E				
	assign d005 = 82;	//	R	
	assign d006 = 83;	//	S	
	assign d007 = 58;	//	:		
	assign d008 = 65;	//	A	
	assign d009 = 120;//	x			
	assign d010 = 66;	//	B	
	assign d011 = 8'h20;				
	assign d012 = 8'h20;				
	assign d013 = 8'h20;			
	assign d014 = 8'h20;				
	assign d015 = 8'h20;			
	
	//Linha inferior
	assign d100 = 80;	//	P
	assign d101 = 76;	//	L		
	assign d102 = 65; //	A	
	assign d103 = 67;	//	C	
	assign d104 = 65;	//	A
	assign d105 = 82;	//	R		
	assign d106 = 58;	//	:		
	assign d107 = 32;				
	assign d108 = lcd_reg[14] + 8'h30;	//Pontuação Player A		
	assign d109 = 120; // x			
	assign d110 = lcd_reg[13] + 8'h30;	//Pontuação Player B			
	assign d111 = 32;		
	assign d112 = 32;				
	assign d113 = 69;	// E				
	assign d114 = 58;	//:
	assign d115 = lcd_reg[15] + 8'h30; //Pontos por Empate
	
endmodule 


