

##########################################################################################
# User-defined variables for logical library setup in dc_setup.tcl
##########################################################################################

set ADDITIONAL_SEARCH_PATH        "/library/T28/Memory/tsn28hpcpl2spsrammacros_180a/AN61001_20180125/TSMCHOME/sram/Front_End/timing_power_noise/NLDM/tsn28hpcpl2spsrammacros_180a/TS1N28HPCPL2LVTB4096X32M4MWBASO/ \
    /library/T28/Memory/tsn28hpcpl2spsrammacros_180a/AN61001_20180125/TSMCHOME/sram/Front_End/timing_power_noise/NLDM/tsn28hpcpl2spsrammacros_180a/TS1N28HPCPL2LVTB2048X32M4MWBASO/ \
    /library/T28/Stdcell/tcbn28hpcplusbwp7t40p140_180a " ;# Directories containing logical libraries,
                                                                              # logical design and script files.

set TARGET_LIBRARY_FILES          "tcbn28hpcplusbwp7t40p140ssg0p81v125c.db \
    TS1N28HPCPL2LVTB2048X32M4MWBASO_ssg0p81v125c.db \
    TS1N28HPCPL2LVTB4096X32M4MWBASO_ssg0p81v125c.db"                   ;#  Logical technology library file

set SYMBOL_LIBRARY_FILES          ""                     ;#  Symbol library file

##########################################################################################
# User-defined variables for physical library setup in dc_setup.tcl
##########################################################################################


set MW_REFERENCE_LIB_DIRS         ""                 ;# Milkyway reference libraries

set TECH_FILE                     ""           ;#  Milkyway technology file

set TLUPLUS_MAX_FILE              ""           ;#  Max TLUPlus file

set MAP_FILE                      ""          ;#  Mapping file for TLUplus
