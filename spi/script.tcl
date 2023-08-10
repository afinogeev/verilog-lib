#digital
gtkwave::addSignalsFromList "testbench.clk"
gtkwave::addSignalsFromList "testbench.rst"
gtkwave::addSignalsFromList "testbench.start"
gtkwave::addSignalsFromList "testbench.ss"
gtkwave::addSignalsFromList "testbench.sck"
gtkwave::addSignalsFromList "testbench.miso"
gtkwave::addSignalsFromList "testbench.mosi"

#data
set data_list [list \
               testbench.m_tx\[7:0\] \
               testbench.m_rx\[7:0\] \
               testbench.s_tx\[7:0\] \
               testbench.s_rx\[7:0\] \
               ]
gtkwave::addSignalsFromList $data_list
gtkwave::highlightSignalsFromList $data_list
gtkwave::/Edit/Data_Format/Decimal
gtkwave::/Edit/UnHighlight_All

#all
gtkwave::/Edit/Highlight_All
gtkwave::/Edit/Color_Format/Cycle
gtkwave::/Edit/UnHighlight_All