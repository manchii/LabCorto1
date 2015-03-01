`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:23:33 02/27/2015 
// Design Name: 
// Module Name:    Reg_AntiRebote 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Reg_AntiRebote(
	input wire clk, rst,
	input wire Switch,            //Switch
	output reg Dato_Sincronizado, Dato_listo 
    );
	 
//declaracion del estado simbolico
localparam [1:0]
	Cero = 2'b00,
	Espera_a_0 = 2'b01,
	Uno = 2'b10,
	Espera_a_1 = 2'b11;

//numero de conteo de bits (2^N*20ns = 40ms)
localparam N=21;
   
   
//declaracion de señal

	reg [1:0] estado_actual, estado_siguiente;
	reg [N-1:0] Cuenta_actual;
	wire [N-1:0] Cuenta_siguiente;
	wire Fin_Cuenta;
	reg Dato_listo_siguiente;

assign Cuenta_siguiente = Cuenta_actual + 1'b1;
assign Fin_Cuenta = (q_reg==0) ? 1'b1 : 1'b0;

always @ (posedge clk, posedge rst)
begin
	if (rst)
	begin
		estado_actual <= Cero;
		Dato_listo  <= 0;
		Cuenta_actual <= 0;
	end
	else
	begin
		estado_actual <= estado_siguiente;
		q_reg <= q_next;
		Dato_listo  <= Dato_listo_siguiente;
		Cuenta_actual <= Cuenta_siguiente;
	end
end

always @*
begin
	estado_siguiente = estado_actual;
	Dato_Sincronizado = 1'b0;
	Dato_listo_siguiente = 1'b0;
//begin case
	case (estado_actual)
	
	Cero:
	begin
		if (Switch)
		begin
			estado_siguiente = Espera_a_1;
		end
	end
        
	Espera_a_1:
	begin
		if (~Switch)
			estado_siguiente = Cero;
		else
			if (Fin_Cuenta)
				estado_siguiente = Uno;
				Dato_listo_siguiente = 1'b1;	
	end
        
	Uno:
	begin
		Dato_Sincronizado = 1'b1;
		if (~Switch)
		begin
			estado_siguiente = Espera_a_0;
		end
	end

	Espera_a_0:
	begin
		if (Switch)
			estado_siguiente = Uno;
		else
			if (Fin_Cuenta)
				estado_siguiente = Cero;
				Dato_listo_siguiente = 1'b1;
	end   
	endcase
end

endmodule
