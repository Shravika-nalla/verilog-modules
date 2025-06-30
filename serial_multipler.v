// Control Unit
module CU (
  input clk, rst, start, cnteqzero, yeqone,
  output reg ldx, ldy, lstotal, sel, dec, enmux, ldtotal);
  
  reg [2:0] PS, NS;
  
  parameter [2:0] S0=0, S1=1, S2=2, S3=3, S4=4, S5=5;
  
  //State Register
  always @(posedge clk, posedge rst)
	begin
		if (rst) PS <= S0;
		else PS <= NS;
	end
  
  //NS Logic
  always @*
  	case (PS)
      S0: if (start) NS = S1; else NS = S0;
      S1: NS = S2;
      S2: if (cnteqzero) NS = S5;
      	  else if (yeqone) NS = S3;
		  else NS = S4;
      S3: NS = S2;
      S4: NS = S2;
      S5: NS = S0;
    endcase
      
  //Output Logic
  	always @(PS)
        begin
         {ldx, ldy, lstotal, sel, dec, ldtotal, enmux} = 0;
         case (PS)
				S1: begin ldx = 1; ldy = 1; end
				S3: begin lstotal = 1; sel = 0; dec = 1; enmux = 1; end
				S4: begin lstotal = 1; sel = 1; dec = 1; enmux = 1; end
				S5: ldtotal = 1;
         endcase
        end
endmodule
