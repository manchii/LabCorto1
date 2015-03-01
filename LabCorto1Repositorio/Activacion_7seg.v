`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    09:44:40 02/27/2015 
// Design Name: 
// Module Name:    Activacion_7seg 
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
module Activacion_7seg(
	input wire Ventilacion,
	input wire Alarma,
	output wire [6:0] Anodo
    );
localparam [6:0]
	A = 7'b1000001,
	V = 7'b0001000;
	 
assign	Anodo = (Ventilacion) ? V : 
			(Alarma) ? A : 7'h0;

endmodule
