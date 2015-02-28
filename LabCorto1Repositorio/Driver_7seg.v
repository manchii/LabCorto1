`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:56:38 02/23/2015 
// Design Name: 
// Module Name:    Driver_7seg
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
module Driver_7seg(
	input wire clk_disp,rst,
	input wire Disp_Enable,
	input wire [6:0] Unidades,
	input wire [6:0] Decenas,
	input wire [6:0] Estado,
	input wire [6:0] Actividad,
	output reg [6:0] Catodo,
	output reg [3:0] Seleccion
);

reg [2:0] estado_actual, estado_siguiente;

//Estados simbolicos

localparam [2:0] 
	idle = 3'b000,
	unidades = 3'b001,
	decenas = 3'b010,
	actividad = 3'b011,
	estado = 3'b100;


always@(posedge clk_disp, posedge rst)
begin
	if(rst)
		estado_actual <= idle;
	else
		estado_actual <= estado_siguiente;
end

always@*
begin
	estado_siguiente = idle;
	Catodo = 7'b1111111; 
	Seleccion = 4'h0;
	case(estado_actual)
		idle:
		begin
			if(Disp_Enable)
				estado_siguiente = unidades;
		end
		unidades:
		begin
			if(Disp_Enable)
			begin
				estado_siguiente = decenas;
				Catodo = Unidades;
				Seleccion = 4'b0001;
			end
			else
				estado_siguiente = idle;
		end
		decenas:
		begin
			if(Disp_Enable)
			begin
				estado_siguiente = actividad;
				Catodo = Decenas;
				Seleccion = Seleccion << 1;
			end
			else
				estado_siguiente = idle;
		end
		actividad:
		begin
			if(Disp_Enable)
			begin
				estado_siguiente = estado;
				Catodo = Actividad;
				Seleccion = Seleccion << 1;
			end
			else
				estado_siguiente = idle;
		end
		estado:
		begin
			if(Disp_Enable)
			begin
				estado_siguiente = unidades;
				Catodo = Estado;
				Seleccion = Seleccion << 1;
			end
			else
				estado_siguiente = idle;
		end
		default:
			estado_siguiente = idle;
	endcase
end



endmodule





/*
module Driver_7seg(
		input wire clk_disp, rst,
		input wire Disp_Enable,
		input wire [7:0] Unidades,
		input wire [7:0] Decenas,
		input wire [7:0] Estado,
		output reg [7:0] Anodo,
		output wire [3:0] Seleccion,
		output wire Catodo
    );

reg [3:0]i_actual, i_siguiente;
reg [7:0] anodo;

always@(posedge clk_disp, posedge rst)
begin	
//	i_actual <= 	Disp_Enable 	? i_siguiente :
//			rst		? 4'b0001 : 4'b0000;	
//	Anodo <= rst ? 8'h00 : anodo;
	if(rst)
	begin
		i_actual<=4'b0001;
		Anodo <= 8'h00;
	end
	else
	begin
		i_actual <= Disp_Enable ? i_siguiente : 4'h0;
		Anodo <= anodo;
	end
end

always@*
begin
	anodo = 8'h00;
	i_siguiente= 4'b0000;
	case(i_actual)
		4'b0001:
		begin
			anodo = Unidades;
			i_siguiente = 4'b0010;
		end		
		4'b0010:
		begin		
			anodo = Decenas;
			i_siguiente = 4'b1000;
		end		
		4'b1000:
			anodo = Estado;
		default: i_siguiente = 4'b0001;
	endcase
end

assign Seleccion=i_actual;


endmodule
*/