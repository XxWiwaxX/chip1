/*
 * Copyright (c) 2026 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Data Input A
    output wire [7:0] uo_out,   // Registered ALU Result
    input  wire [7:0] uio_in,   // Data Input B
    output wire [7:0] uio_out,  // Status Flags (Optional)
    output wire [7:0] uio_oe,   // Bidirectional Enable
    input  wire       ena,      
    input  wire       clk,      // Clock signal
    input  wire       rst_n     // Active-low Reset
);

  // Using the top 3 bits of ui_in as the Operation Selector (OpCode)
  // Using the bottom 5 bits of ui_in as Operand A
  wire [2:0] sel = ui_in[7:5];
  wire [7:0] a   = {3'b000, ui_in[4:0]};
  wire [7:0] b   = uio_in;

  reg [7:0] alu_reg; // This is our internal storage (the Register)

  // Sequential Logic Block
  always @(posedge clk) begin
    if (!rst_n) begin
      // Reset the register to zero
      alu_reg <= 8'b0;
    end else if (ena) begin
      // Perform calculation based on 'sel' and store it
      case (sel)
        3'b000: alu_reg <= a + b;   // ADD
        3'b001: alu_reg <= a - b;   // SUB
        3'b010: alu_reg <= a & b;   // AND
        3'b011: alu_reg <= a | b;   // OR
        3'b100: alu_reg <= a ^ b;   // XOR
        3'b101: alu_reg <= ~a;      // NOT
        3'b110: alu_reg <= a << 1;  // SHL
        3'b111: alu_reg <= a >> 1;  // SHR
        default: alu_reg <= 8'b0;
      endcase
    end
  end

  // Drive the output from the register
  assign uo_out  = alu_reg;
  
  // Clean up unused outputs/IOs
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0; 

endmodule
