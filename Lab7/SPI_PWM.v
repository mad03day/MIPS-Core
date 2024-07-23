module SPI_PWM(i_clk, i_rst_n, i_spi_mosi, i_spi_clk, i_spi_cs, o_pwm);

input i_clk;
input i_rst_n;
input i_spi_mosi;
input i_spi_clk;
input i_spi_cs;
output o_pwm;




reg [15:0] mem_block [1:0]; 

wire [7:0]spi_data;
wire clk_div;
wire tr_cmplt;


wire addr;
wire [15:0] o_data;
wire we;

wire pwm;

assign o_pwm = pwm;

simple_spi  SPI         (   .i_clk(i_clk),
                            .i_rst_n(i_rst_n),
                            .i_spi_mosi(i_spi_mosi),
                            .i_spi_sck(i_spi_clk),
                            .i_spi_cs(i_spi_cs),
                            .o_data(spi_data),
                            .o_cmplt(tr_cmplt)
                        );

freq_div    divider     (   .i_clk(i_clk),
                            .i_rst_n(i_rst_n),
                            .i_div(mem_block[0]),
                            .o_clk(clk_div)
                        );

control_spi     controler   (   .i_clk(i_clk), 
                            .i_rst_n(i_rst_n),
                            .i_tr(tr_cmplt), 
                            .i_data(spi_data), 
                            .o_data(o_data), 
                            .o_addr(addr), 
                            .o_we(we)
                        );

pwm_cntl    PWM         (   .i_clk(clk_div), 
                            .i_rst_n(i_rst_n), 
                            .i_cr(mem_block[1]), 
                            .o_pwm(pwm)
                        );



always@(posedge i_clk) begin
    if(we) begin
        mem_block [addr] <= o_data;
    end
end


endmodule