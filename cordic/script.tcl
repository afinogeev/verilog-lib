#digital
gtkwave::addSignalsFromList "testbench.clk"
gtkwave::addSignalsFromList "testbench.rst"

#analog
set analog_list [list \
               testbench.cos\[15:0\] \
               testbench.sin\[15:0\] \
               gen.angle\[33:0\] \
               testbench.cos_step\[15:0\] \
               testbench.sin_step\[15:0\] \
               gen_step.angle\[33:0\] \
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