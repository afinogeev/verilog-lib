#digital
gtkwave::addSignalsFromList "testbench.clk"
gtkwave::addSignalsFromList "testbench.rst"
gtkwave::addSignalsFromList "testbench.prs_out"
gtkwave::addSignalsFromList "testbench.rand_out"

#analog
#set analog_list [list \
#                testbench.sin\[15:0\] \
#                testbench.out\[15:0\] \
#                ]
#gtkwave::addSignalsFromList $analog_list
#gtkwave::highlightSignalsFromList $analog_list
#gtkwave::/Edit/Data_Format/Signed_Decimal
#gtkwave::/Edit/Data_Format/Analog/Step
#gtkwave::/Edit/UnHighlight_All

#all
gtkwave::/Edit/Highlight_All
gtkwave::/Edit/Color_Format/Cycle
gtkwave::/Edit/UnHighlight_All