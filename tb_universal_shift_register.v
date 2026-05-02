`timescale 1ns/1ps

module tb_universal_shift_register;

reg clk;
reg reset;
reg [1:0] mode;
reg [3:0] parallel_in;
reg serial_left_in;
reg serial_right_in;
wire [3:0] q;

universal_shift_register uut (
    .clk(clk),
    .reset(reset),
    .mode(mode),
    .parallel_in(parallel_in),
    .serial_left_in(serial_left_in),
    .serial_right_in(serial_right_in),
    .q(q)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("universal_shift_register.vcd");
    $dumpvars(0, tb_universal_shift_register);

    reset = 1;
    mode = 2'b00;
    parallel_in = 4'b0000;
    serial_left_in = 0;
    serial_right_in = 0;

    #10 reset = 0;

    // Parallel Load: q = 1011
    #10 mode = 2'b11; parallel_in = 4'b1011;

    // Hold: q stays 1011
    #10 mode = 2'b00;

    // Shift Right: serial_right_in enters from left
    // q = 0101
    #10 mode = 2'b01; serial_right_in = 0;

    // Shift Left: serial_left_in enters from right
    // q = 1011
    #10 mode = 2'b10; serial_left_in = 1;

    // Parallel Load: q = 1100
    #10 mode = 2'b11; parallel_in = 4'b1100;

    // Hold: q stays 1100
    #10 mode = 2'b00;

    #20 $finish;
end

endmodule