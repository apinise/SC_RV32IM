module multiplier #(
  parameter DWIDTH = 32
)(
  input   logic [DWIDTH-1:0] Mul_In_A,
  input   logic [DWIDTH-1:0] Mul_In_B,
  input   logic [2:0]        Mul_Sel,
  output  logic [DWIDTH-1:0] Mul_Out_Upper,
  output  logic [DWIDTH-1:0] Mul_Out_Lower
);

////////////////////////////////////////////////////////////////
////////////////////////   Parameters   ////////////////////////
////////////////////////////////////////////////////////////////

localparam MUL    = 3'b000;
localparam MULH   = 3'b001;
localparam MULHSU = 3'b010;
localparam MULHU  = 3'b011;
localparam DIV    = 3'b100;
localparam DIVU   = 3'b101;
localparam REM    = 3'b110;
localparam REMU   = 3'b111;

////////////////////////////////////////////////////////////////
///////////////////////   Internal Net   ///////////////////////
////////////////////////////////////////////////////////////////

logic [63:0]        mul_sum;

////////////////////////////////////////////////////////////////
//////////////////////   Instantiations   //////////////////////
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////
///////////////////////   Module Logic   ///////////////////////
////////////////////////////////////////////////////////////////

always_comb begin
  casez(Mul_Sel) 
      MULHSU:   mul_sum = Mul_In_A * Mul_In_B;
      MULHU:    mul_sum = $signed(Mul_In_A) * Mul_In_B;
      DIV:      mul_sum = $signed(Mul_In_A) / $signed(Mul_In_B);
      DIVU:     mul_sum = Mul_In_A / Mul_In_B;
      REM:      mul_sum = $signed(Mul_In_A) % $signed(Mul_In_B);
      REMU:     mul_sum = Mul_In_A % Mul_In_B;
      default:  mul_sum = $signed(Mul_In_A) * $signed(Mul_In_B);
  endcase
end

assign Mul_Out_Upper = mul_sum[63:32];
assign Mul_Out_Lower = mul_sum[31:0];

////////////////////////////////////////////////////////////////
//////////////////   Instantiation Template   //////////////////
////////////////////////////////////////////////////////////////
/*
multiplier multiplier (
  .Mul_In_A(),
  .Mul_In_B(),
  .Mul_Sel(),
  .Mul_Out_Upper(),
  .Mul_Out_Lower()
);
*/

endmodule