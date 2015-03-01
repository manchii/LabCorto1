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

// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module Control(
	input wire Dato_listo,
	input wire Peligro,
	input wire rst,clk,
	output reg Activar_Decidir,
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
	Activar_Decidir=1'b0;
	case(estado_actual)
		leer:
		begin
			if(Dato_listo)
				estado_siguiente=decidir;
				
		end
		decidir:
		begin
			Activar_Decidir=1'b1;
			if(Peligro)
				estado_siguiente=alerta;
			else
				estado_siguiente=leer;
		end
		alerta:
		begin
			if(Dato_listo)
				estado_siguiente=leer;
		end		
		default: estado_siguiente=leer;
	endcase
	
end

assign Estados = estado_actual;

endmodule
