#digital
gtkwave::addSignalsFromList "testbench.clk"
gtkwave::addSignalsFromList "testbench.rst"

#analog
set analog_list [list \
                testbench.sin_21\[15:0\] \
                testbench.sin_20\[15:0\] \
                testbench.sin_15\[15:0\] \
                testbench.sin_12\[15:0\] \
                ]
gtkwave::addSignalsFromList $analog_list
gtkwave::highlightSignalsFromList $analog_list
gtkwave::/Edit/Data_Format/Signed_Decimal
gtkwave::/Edit/Data_Format/Analog/Step
gtkwave::/Edit/UnHighlight_All


#all
gtkwave::/Edit/Highlight_All
gtkwave::/Edit/Color_Format/Cycle
gtkwave::/Edit/UnHighlight_All