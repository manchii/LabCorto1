`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:37:25 02/21/2015 
// Design Name: 
// Module Name:    Control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
/* do
   
*/
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module Control(
	input wire Temp_En,
	input wire Danger,
	input wire rst,clk,
	output reg Enable_Sensar,
	output reg Enable_Activacion,
	output wire [1:0] Estados
);

localparam [1:0]
	leer = 2'b01,
	decidir = 2'b10,
	alerta = 2'b11;

reg [1:0] estado_actual, estado_siguiente;

always@(posedge clk,posedge rst)
	
	if(rst)
		estado_actual <= leer;
	else
		estado_actual <= estado_siguiente;


always@*
begin
	estado_siguiente=estado_actual;
	Enable_Sensar=1'b0;
	Enable_Activacion=1'b0;
	case(estado_actual)
		leer:
		begin
			Enable_Sensar=1'b1;
			if(Temp_En)
				estado_siguiente=decidir;
				
		end
		decidir:
		begin
			Enable_Activacion=1'b1;
			if(Danger)
				estado_siguiente=alerta;
		end
		alerta:
		begin
			if(rst)
				estado_siguiente=leer;
		end		
		default: estado_siguiente=leer;
	endcase
	
end

assign Estados = estado_actual;

endmodule
