`timescale 10ns/1ns
module test_CU();
  	reg  clk, rst, start, cnteqzero, yeqone;
    wire ldx, ldy, lstotal, sel, dec, enmux, ldtotal;

    //Instantiate the design-under-test (dut)
  CU dut(.clk(clk), .rst(rst), .start(start), .cnteqzero(cnteqzero), .yeqone(yeqone), .ldx(ldx), .ldy(ldy), .lstotal(lstotal), .sel(sel), .dec(dec), .enmux(enmux), .ldtotal(ldtotal)); 

    //report the circuit response (display response)
    initial begin
      $monitor($time, "ns clk=%b, rst=%b, start=%b, cnteqzero=%b, yeqone=%b, ldx=%b, ldy=%b, lstotal=%b, sel=%b, dec=%b, enmux=%b ldtotal=%b", clk, rst, start, cnteqzero, yeqone, ldx, ldy, lstotal, sel, dec, enmux, ldtotal);
    end
  
  	//generate clock signal period=(2x10ns)x2=40ns
  	initial begin 
      clk = 1'b0;
      forever #2 clk = ~clk;
    end

    //provide input test vectored
    initial begin
      $dumpvars(1, test_CU); //REMOVE THIS LINE IF USING QUARTUS II

        #0		rst=1;	start=0;	cnteqzero=0;	yeqone=0; 	//reset
      	#10		rst=0;		//wait for start
      	@(posedge clk)		
      	start=1;			//initiate CU
      	@(posedge clk)		
      	cnteqzero=0;			
      	@(posedge clk)		
      	yeqone=1;						
      	@(posedge clk)		
      	yeqone=1;			
      	@(posedge clk)		
      	yeqone=0;			
      	@(posedge clk)		
      	yeqone=0;			
      	@(posedge clk)		
      	cnteqzero=1;		
      	#10		$finish;
    end
endmodule
