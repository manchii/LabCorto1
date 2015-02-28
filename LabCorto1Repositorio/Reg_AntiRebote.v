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
	input wire clk, reset,
	input wire sw,            //Switch
	output reg Dato_Sincronizado, Dato_listo 
    );
	 
//declaracion del estado simbolico
localparam [1:0]
	zero = 2'b00,
	wait0 = 2'b01,
	one = 2'b10,
	wait1 = 2'b11;

//numero de conteo de bits (2^N*20ns = 40ms)
localparam N=21;
   
   
//declaracion de señal

	reg [1:0] state_reg, state_next;
	reg [N-1:0] q_reg;
	wire [N-1:0] q_next;
	wire m_tick;
	reg Control_next_tick;
   

always @ (posedge clk, posedge reset)
begin
	if(reset)
		q_reg <= 0;
	else
		q_reg <= q_next;
end

assign q_next = q_reg + 1'b1;
assign m_tick = (q_reg==0) ? 1'b1 : 1'b0;

always @ (posedge clk, posedge reset)
begin
	if (reset)
	begin
		state_reg <= zero;
		q_reg <= 0;
		Dato_listo  <= 0;
	end
	else
	begin
		state_reg <= state_next;
		q_reg <= q_next;
		Dato_listo  <= Dato_listo_Siguiente;
	end
end

always @*
begin
	state_next = state_reg;
	Dato_Sincronizado = 1'b0;
	Dato_listo_Siguiente = 1'b0;
//begin case
	case (state_reg)
	
	zero:
	begin
		if (sw)
		begin
			state_next = wait1;
		end
	end
        
	wait1:
	begin
		if (~sw)
			state_next = zero;
		else
			if (m_tick)
				state_next = one;
				Dato_listo_Siguiente = 1'b1;	
	end
        
	one:
	begin
		Dato_Sincronizado = 1'b1;
		if (~sw)
		begin
			state_next = wait0;
		end
	end

	wait0:
	begin
		if (sw)
			state_next = one;
		else
			if (m_tick)
				state_next = zero;
				Dato_listo_Siguiente = 1'b1;
	end   
	endcase
end

endmodule
