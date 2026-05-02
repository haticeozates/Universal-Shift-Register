module universal_shift_register (
    input wire clk,
    input wire reset,
    input wire [1:0] mode,
    input wire [3:0] parallel_in,
    input wire serial_left_in,
    input wire serial_right_in,
    output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 4'b0000;
    end
    else begin
        case (mode)
            2'b00: q <= q;                              // Hold
            2'b01: q <= {serial_right_in, q[3:1]};      // Shift right
            2'b10: q <= {q[2:0], serial_left_in};       // Shift left
            2'b11: q <= parallel_in;                    // Parallel load
            default: q <= q;
        endcase
    end
end

endmodule