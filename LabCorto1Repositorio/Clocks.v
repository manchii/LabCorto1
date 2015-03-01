`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    23:18:58 02/26/2015 
// Design Name: 
// Module Name:    Clocks 
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
module Clocks(
	input wire clk,rst,       //entradas para el reloj
	output wire clk_display   //salida del reloj
    );
reg [20:0]Contador, Cuenta_siguiente; 

//Comportamiento del reloj
always@(posedge clk, posedge rst) //funciona cuando hay cambio a flanco positivo 
begin
	if(rst)
		Contador <= 21'h0;
	else
		Contador <=Cuenta_siguiente; 
end

always@*
begin
	case(Contador)
				21'hffffff: Cuenta_siguiente =21'b0;
				default: Cuenta_siguiente = Contador + 1'b1;
	endcase
end

assign clk_display = Contador[20];

endmodule
