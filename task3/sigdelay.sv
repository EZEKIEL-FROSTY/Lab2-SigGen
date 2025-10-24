module sigdelay #(
    parameter   A_WIDTH = 9,
                D_WIDTH = 8
)(
    // interface signals
    input logic                     clk,    // clock
    input logic                     rst,    // reset
    input logic                     en,     // enable
    input logic [A_WIDTH-1:0]       incr,   // increment for addr counter
    input logic [A_WIDTH-1:0]       offset,
    input logic                     wr,
    input logic                     rd,
    input logic [D_WIDTH-1:0]       mic_signal,
    output logic [D_WIDTH-1:0]      delayed_signal
);

    logic [A_WIDTH-1:0]             address; // interconnect wires
    logic [A_WIDTH-1:0]             address2;

counter addrCounter(
    .clk(clk),
    .rst(rst),
    .en(en),
    .incr(incr),
    .count(address)
);

assign address2 = address - offset;

ram ram512_8(
    .clk(clk),
    .wr_en(wr),
    .rd_en(rd),
    .wr_addr(address),
    .rd_addr(address2),
    .din(mic_signal),
    .dout(delayed_signal)
);

endmodule
