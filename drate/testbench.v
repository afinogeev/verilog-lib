`timescale 10ns/1ns

`include "types.v"
`include "fir_lp_coefs.v"

module testbench();

reg clk;
reg rst;

//////////SIN/////////////

real PI=3.14159265358979323846;
real last_time=0; //Sec
real current_time=0; //Sec
real angle=0;	//Rad
real frequency=100; //Hz
integer freq_x100kHz=0; //*100kHz
reg signed [15:0]sin16;

//function which calculates Sinus(x)
function real sin;
input x;
real x;
real x1,y,y2,y3,y5,y7,sum,sign;
 begin
  sign = 1.0;
  x1 = x;
  if (x1<0)
  begin
   x1 = -x1;
   sign = -1.0;
  end
  while (x1 > PI/2.0)
  begin
   x1 = x1 - PI;
   sign = -1.0*sign;
  end  
  y = x1*2/PI;
  y2 = y*y;
  y3 = y*y2;
  y5 = y3*y2;
  y7 = y5*y2;
  sum = 1.570794*y - 0.645962*y3 +
      0.079692*y5 - 0.004681712*y7;
  sin = sign*sum;
 end
endfunction

task set_freq;
input f;
real f;
begin
	frequency = f;
	freq_x100kHz = f/100000.0;
end
endtask


always @(posedge clk)
begin
	current_time = $realtime;
	angle = angle+(current_time-last_time)*2*PI*frequency/1000000000.0;
	while ( angle > PI*2.0 )
	begin
		angle = angle-PI*2.0;
	end 
	sin16 = 32767*sin(angle);
	last_time = current_time;
end

initial
begin
    set_freq(1000000);
end

/////////////////////////////

initial begin
	$dumpfile("out.vcd");
	$dumpvars(0,testbench);
	clk = 0;
	#0.5 forever #0.5 clk = !clk;
end

initial begin
    rst = 1;
    repeat (10) @(posedge clk);
    rst = 0;
end

initial
begin
    for(integer i = 0; i < 100; i++) begin
        $display("progress: %d %%", i);
        #100;
    end
	$finish;
end

`ws16_t out;
wire clk_l;
DRATE #( .F_H(60), .F_L(3), .FIR_SLICE(37) ) drate(.clk(clk), .rst(rst), .fir_coefs(`lp64_r12_coefs), .in(sin16), .out(out), .clk_l(clk_l));

endmodule