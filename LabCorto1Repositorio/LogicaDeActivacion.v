`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:58:44 02/21/2015 
// Design Name: 
// Module Name:    LogicaDeActivacion 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
/*
	Este módulo consiste en una lógica combinacional del cual se describe a partir de
	la siguente tabla de verdad:
	Ignicion		Presencia		AlertaFuerte		AlertaDebil		|| Alarma		Ventilacion
	0				0			X		X			||		0					0
		0				1						0						0			||		0					0
		0				1						0						1			||		1					0
		0				1						1						X			||		1					1
		1				X						X						X			||		0					0
	
	Los resultados serán guardados en un registro.
*/
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////


module LogicaDeActivacion(
	input wire [1:0] Alerta, 						//Señal obtenida del Sistema_Alerta 
	input wire rst,clk,
	input wire Presencia,
	input wire Ignicion,	//Señales auxiliares
	input wire Enable,
	input wire Enable_Activacion,
	output reg Alarma,								//Activa la alarma
	output reg Ventilacion,				//Activa el sistema de ventilación
	output wire Danger    				//Señal de control
);

reg alarma_mem,ventilacion_mem;

//Declaración simbólica de las salidas de activación

localparam
	Encendido = 1'b1,
	Apagado = 1'b0;


always@(posedge clk, posedge rst)
begin
if(rst)
begin
	alarma_mem <= Apagado;
	ventilacion_mem <= Apagado;
	Alarma <= Apagado;
	Ventilacion <= Apagado;
end		
else
begin
		//Descripción del Proceso
if(Enable)
	begin	
	alarma_mem <= 		Ignicion 	? Apagado : 		//Apagar en caso de haber ignición
				~Presencia 	? Apagado :		//Apagar si no hay presencia		
				Alerta[1]	? Encendido : Apagado;	//Encender si hay alerta debil
		
	ventilacion_mem <= 		Ignicion	? Apagado :		//Apagar en caso de haber ignición
				~Presencia	? Apagado :		//Apagar si no hay presencia
				Alerta[0]	? Encendido : Apagado;	//Encender si hay alerta fuerte
	end
if(Enable_Activacion)
	begin 
		Alarma <= alarma_mem;
		Ventilacion <= ventilacion_mem;
	end

end

end

//Asignación de las salidas

assign Danger = alarma_mem | ventilacion_mem; //Señal de Control

		
		
endmodule
