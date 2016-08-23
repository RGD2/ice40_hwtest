module top (
    input pclk,
    output [106:0] D,
    output SCL,
    output MOSI,
    input MISO
);

    localparam BITS = 5;
    localparam LOG2DELAY = 22;
    
    function [BITS-1:0] bin2gray(input [BITS-1:0] in);
        integer i;
        reg [BITS-1:0] temp;
        begin
            temp = in;
            for (i=0; i<BITS; i=i+1)
                bin2gray[i] = ^temp[i +: 2];
        end
    endfunction
    
    
    reg [BITS+LOG2DELAY-1:0] counter = 0;
    
    always@(posedge pclk)
        counter <= counter + 1;
        
        
    reg [106:0] rng =107'b00000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000;
    
    always@(posedge counter[LOG2DELAY-2])
        rng <= ({rng[0],(rng >> 1)})^(rng | {(rng << 1),rng[106]});        
        
    assign D = rng;  // = bin2gray(counter >> LOG2DELAY-1);
    
wire [15:0] spirx;
wire spirunning;
spimaster _spi (        .clk(pclk),
                                .we(counter[16]),
                                .both(counter[17]),
                                .tx(rng[15:0]),
                                .rx(spirx),
                                .running(spirunning),
                                .MOSI(MOSI),
                                .SCL(SCL),
                                .MISO(MISO));

endmodule 
