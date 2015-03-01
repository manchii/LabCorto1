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

Reg_AntiRebote ModuloRegistroTemp0(
	.clk(),//1bit
	.rst(),//1bit
	.Switch(),//1bit
	.Dato_Sincronizado(),//1bit
	.Dato_listo()//1bit
);

Reg_AntiRebote ModuloRegistroTemp1(
	.clk(),//1bit
	.rst(),//1bit
	.Switch(),//1bit
	.Dato_Sincronizado(),//1bit
	.Dato_listo()//1bit
);

Reg_AntiRebote ModuloRegistroTemp2(
	.clk(),//1bit
	.rst(),//1bit
	.Switch(),//1bit
	.Dato_Sincronizado(),//1bit
	.Dato_listo()//1bit
);

Reg_AntiRebote ModuloRegistroTemp3(
	.clk(),//1bit
	.rst(),//1bit
	.Switch(),//1bit
	.Dato_Sincronizado(),//1bit
	.Dato_listo()//1bit
);

Reg_AntiRebote ModuloRegistroTemp4(
	.clk(),//1bit
	.rst(),//1bit
	.Switch(),//1bit
	.Dato_Sincronizado(),//1bit
	.Dato_listo()//1bit
);

Reg_AntiRebote ModuloRegistroPresencia(
	.clk(),//1bit
	.rst(),//1bit
	.Switch(),//1bit
	.Dato_Sincronizado(),//1bit
	.Dato_listo()//1bit
);

Reg_AntiRebote ModuloRegistroIgnicion(
	.clk(),//1bit
	.rst(),//1bit
	.Switch(),//1bit
	.Dato_Sincronizado(),//1bit
	.Dato_listo()//1bit
);

LogicaDeActivacion ModulodeActivacion(
	.Alerta(),//2bits
	.rst(),//2bits
	.clk(),//1bit
	.Presencia(),//1bit
	.Ignicion(),//1bit
	.Activar_Decidir()//1bit,
	.Alarma(),//1bit
	.Ventilacion(),//1bit
	.Peligro()//1bit
);

Flag_Danger ModuloAvisodePeligro(
	.Temperatura(), //5bits
	.Alerta() //2bits
);

Driver_7seg ModuloControlador7seg(
	.clk_disp(),//1bit
	.rst(), //1bit
	.Unidades(), //7bits
	.Decenas(), //7bits
	.Estado(), //7bits
	.Actividad(), //7bits
	.Catodo(), //7bits
	.Seleccion() //4bits
);

Deco7seg ModuloDeco7seg_Unidades(
	.hex(), //4bits
	.sseg(), //7bits
);

Deco7seg ModuloDeco7seg_Decenas(
	.hex(), //4bits
	.sseg(), //7bits
);

ConversorBCD ModuloConversorBCD (
	.Temperatura_sincronizada(), //5bits
	.Decenas(), //4bits
	.Unidades() //4bits
);

Control ModuloControl (
	.Dato_listo(),//1bit
	.Peligro(),//1bit
	.rst(),//1bit
	.Activar_Decidir(),//1bit
	Estados() //2bits
);

Clocks ModuloClock_display (
	.clk(),	//1bit
	.rst(),	//1bit
	.clk_display() //1bit
);

Activacion_7seg ModuloActivacion_7seg (
	.Ventilacion(), //1bit
	.Alarma(),	//1bit
	.Activacion()	//7bits
);


endmodule
