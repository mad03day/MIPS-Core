module freq_div(i_clk, i_rst_n, i_div, o_clk);

input i_clk;
input i_rst_n;
input [7:0]i_div;

output o_clk;

reg clk;
reg [7:0] counter;

assign o_clk = clk;

always @(posedge i_rst_n)
begin
    counter <= 8'h00;
    clk <= 1'b0;
end

always @(posedge i_clk)
begin
    if(counter == i_div)
    begin
        counter <= 8'h00;
        clk <= ~clk;
    end
    else
        counter <= counter + 1;
end

endmodule