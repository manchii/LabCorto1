`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    22:25:51 02/26/2015 
// Design Name: 
// Module Name:    Sistema_Completo 
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
module Sistema_Completo(
	input wire [4:0] Temperatura,
	input wire Presencia,
	input wire Ignicion,
	input wire clk,rst,
	output wire Ventilacion,
	output wire Alarma,
	output wire [7:0] Catodo,
	output wire [3:0] Seleccion
    );

wire [4:0] Temperatura_Registro;
wire Presencia_Registro;
wire Ignicion_Registro;
wire [1:0] Alerta;
wire Unidades, Decenas, Estado;




endmodule
