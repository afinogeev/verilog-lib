cd %~dp0

del /f out.iv
del /f out.vcd

iverilog -o out.iv -c makefile
vvp out.iv -fst
gtkwave out.vcd --script=script.tcl