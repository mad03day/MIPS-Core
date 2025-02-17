module shiftLeftBy2(i_data, o_data);

parameter WIDTH = 32;

input     [WIDTH-1:0]   i_data;
output    [WIDTH-1:0]   o_data;

assign o_data = { i_data[WIDTH-3:0], 2'b00 };

endmodule