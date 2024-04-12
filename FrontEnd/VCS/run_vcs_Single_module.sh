# TOP_MODULE=ALU_Control
TOP_MODULE=chain
vcs ../Netlist/rtl/${TOP_MODULE}_tb.v ../Netlist/rtl/${TOP_MODULE}.v /library/T28/Memory/tsn28hpcpl2spsrammacros_180a/AN61001_20180125/TSMCHOME/sram/Front_End/verilog/tsn28hpcpl2spsrammacros_180a/TS1N28HPCPL2LVTB2048X32M4MWBASO/TS1N28HPCPL2LVTB2048X32M4MWBASO_ssg0p81v125c.v /library/T28/Memory/tsn28hpcpl2spsrammacros_180a/AN61001_20180125/TSMCHOME/sram/Front_End/verilog/tsn28hpcpl2spsrammacros_180a/TS1N28HPCPL2LVTB4096X32M4MWBASO/TS1N28HPCPL2LVTB4096X32M4MWBASO_ssg0p81v125c.v -kdb -lca -l test.log +v2k -debug_all -full64
./simv
./simv -gui