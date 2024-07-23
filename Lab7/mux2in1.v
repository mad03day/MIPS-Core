module mux2in1(i_dat0, i_dat1, i_control, o_dat);

parameter WIDTH = 32;

input   [WIDTH-1:0]   i_dat0, i_dat1; 
input                 i_control;
output  [WIDTH-1:0]   o_dat;

reg [WIDTH-1:0] o_data;

assign o_dat = o_data;

always@* begin
	if(i_control == 1) begin
		o_data <= i_dat1;
	end else begin
		o_data <= i_dat0;
	end
end

endmodule