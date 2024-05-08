suppress_message VER-936
set DESIGN_NAME MIPS_Core
set RESULT_DIR res 
# set root_dir /home/jjt/workspace/MIPS

# read_verilog ${root_dir}/FrontEnd/Netlist/rtl/${DESIGN_NAME}.v
analyze -format verilog [list ${root_dir}/FrontEnd/Netlist/rtl/${DESIGN_NAME}.v \
                            ${root_dir}/FrontEnd/Netlist/rtl/ALU_Control.v \
                            ${root_dir}/FrontEnd/Netlist/rtl/ALU.v \
                            ${root_dir}/FrontEnd/Netlist/rtl/Control.v \
                            ${root_dir}/FrontEnd/Netlist/rtl/Data_Memory_16384x32.v \
                            ${root_dir}/FrontEnd/Netlist/rtl/Instruction_Memory.v \
                            ${root_dir}/FrontEnd/Netlist/rtl/PC_Reg.v \
                            ${root_dir}/FrontEnd/Netlist/rtl/Reg_EX2MEM.v \
                            ${root_dir}/FrontEnd/Netlist/rtl/Reg_ID2EX.v \
                            ${root_dir}/FrontEnd/Netlist/rtl/RegFile32x32.v \
                            ${root_dir}/FrontEnd/Netlist/rtl/Sign_Extend.v \
                            ]
elaborate ${DESIGN_NAME}
write -hierarchy -format ddc -output ${root_dir}/FrontEnd/DC/${RESULT_DIR}/${DESIGN_NAME}.elab.ddc
current_design ${DESIGN_NAME}
link

read_sdc ${root_dir}/FrontEnd/DC/sdc/${DESIGN_NAME}.con
# set dont_bind_unused_pins_to_logic_constant true

set_dont_touch instr_mem/instruction_ram
set_dont_touch data_memory/ram0
set_dont_touch data_memory/ram1
set_dont_touch data_memory/ram2
set_dont_touch data_memory/ram3
set_max_area 0

set_operating_conditions -max ssg0p81v125c

set_flatten false
set_structure true
compile_ultra -no_autoungroup
change_names -rules verilog -hierarchy

write -hierarchy -format ddc -output ${root_dir}/FrontEnd/DC/${RESULT_DIR}/${DESIGN_NAME}.ddc
# write_file -format verilog -output ${root_dir}/FrontEnd/Netlist/gate-level/${DESIGN_NAME}.v
write -f verilog -hierarchy -output ${root_dir}/FrontEnd/Netlist/gate-level/${DESIGN_NAME}.v