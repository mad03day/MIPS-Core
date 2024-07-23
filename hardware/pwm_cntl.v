module pwm_cntl(i_clk, i_rst_n, i_cr, o_pwm);

input i_clk, i_rst_n;
input [15:0] i_cr;

output o_pwm;

reg [15:0] counter;
reg pwm;

assign o_pwm = pwm;

always @(posedge i_rst_n)
begin
    counter <= 16'd0;
    pwm <= 1'b0;
end

always @(posedge i_clk)
begin
    if( counter <= 16'hFFFF)
    begin
        pwm = (i_cr > counter) ? 1'b1 : 1'b0;
        counter <= counter + 1;
    end
    else
        counter <= 0; 
    
end

endmodule