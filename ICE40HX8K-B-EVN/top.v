module top (
    input pclk,
    output [109:0] D
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
    
    always@(posedge clk)
        counter <= counter + 1;
        
        
    reg [109:0] rng = 110'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001;
    
    always@(posedge counter[LOG2DELAY-2])
        rng <= ({rng[0],(rng >> 1)})^(rng | {(rng << 1),rng[109]});        
        
    assign D = rng;  // = bin2gray(counter >> LOG2DELAY-1);
    
endmodule 
