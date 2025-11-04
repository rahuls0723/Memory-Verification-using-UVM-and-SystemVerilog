module single_port_ram(
    input wire Clock,
    input wire Resetn,
    input wire Enable,
    input wire Write_en,
    input wire [3:0] Address,
    input wire [31:0] Data_in,
    output reg [31:0] Data_out,
    output reg Valid_out
);
reg [31:0] memory[0:15];
always@(posedge Clock or negedge Resetn)begin
    if (!Resetn)begin
        foreach(memory[i])
            memory[i] <= 0;
        Data_out <= 0;
        Valid_out <= 0;
    end 
    else begin
        if(Enable)begin
            if(Write_en) begin
                memory[Address] <= Data_in;
                Valid_out <= 0;
            end
            else begin
                Data_out <= memory[Address];
                Valid_out <= 1;
            end
        end
    end
end
endmodule