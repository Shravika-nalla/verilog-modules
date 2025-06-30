module moore_110_detector (
    input clk,
    input reset,
    input x,
    output reg z
);

// Define states
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

// State registers
reg [1:0] state, next_state;

// Moore machine implementation
always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= S0;
        z <= 1'b0;
    end else begin
        state <= next_state;
        case (next_state)
            S0: z <= 1'b0;
            S1: z <= 1'b0;
            S2: z <= 1'b0;
            S3: z <= 1'b1;
        endcase
    end
end

// Next state logic
always @(state, x) begin
    case (state)
        S0: next_state = x ? S1 : S0;
        S1: next_state = x ? S1 : S2;
        S2: next_state = x ? S3 : S0;
        S3: next_state = x ? S1 : S0;
        default: next_state = S0;
    endcase
end

endmodule
