`timescale 1ns/1ns

`include "fir_lp_coefs.v"

module testbench();

reg clk;
initial clk=0;
always
	#25 clk = ~clk;
	
///// SIN16 ///////////////
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
	$display("%f %f",current_time,angle);
	while ( angle > PI*2.0 )
	begin
		angle = angle-PI*2.0;
	end 
	sin16 = 32767*sin(angle);
	last_time = current_time;
end
/////////////////////////////////

//low-pass filter
wire signed [15:0]out;
FIR_NORM #( .TAPS(64) ) fir(
	.clk(clk),
	.coefs( `lp64_r64_coefs ),
	.in(sin16),
	.out(out)
	);

integer i;
real f;

initial
begin
	$dumpfile("out.vcd");
	$dumpvars(0,testbench);
	f=100000;
	for(i=0; i<500; i=i+1)
	begin
		set_freq(f);
		#1000;
		f=f+1000;
	end
	$finish;
end

endmodule