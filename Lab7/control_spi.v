module control_spi(i_clk, i_rst_n, i_data, i_tr, o_data, o_addr, o_we);

input i_clk;
input i_rst_n;
input i_tr;
input [7:0] i_data;

output [15:0] o_data;
output o_addr;
output o_we;

reg is_div, is_cr0, is_cr1, addr, we;
reg [15:0] data;

assign o_we = we;
assign o_addr = addr;

assign o_data = data;

always @(posedge i_rst_n)
begin
    data <= 15'd0;
    is_div <= 1'b0;
    is_cr0 <= 1'b0;
    is_cr1 <= 1'b0;
    we <= 1'b0;
end

always @(negedge i_tr)
begin
        if ((is_div == 0) && (is_cr0 == 0) && (is_cr1 == 0))
        begin
            case(i_data)
            8'h08:              // Command for set data in Compare Register
                is_cr0 <= 1'b1;
            8'h09:              // Command for set data in Divider
                is_div <= 1'b1;
            endcase
        end
        else
        begin
            if (is_div)
            begin
                data <= {8'd0, i_data};
                is_div <= 1'b0;
                addr <= 1'b0;
                we <= 1'b1; 
            end
            if (is_cr0)
            begin
                data <= {8'd0, i_data};
                is_cr0 <= 1'b0;
                is_cr1 <= 1'b1;
                we <= 1'b0;
            end
            if (is_cr1)
            begin
                data <= {data[7:0], i_data};
                is_cr1 <= 1'b0;
                addr <= 1'b1;
                we <= 1'b1;
            end
        end
end

endmodule