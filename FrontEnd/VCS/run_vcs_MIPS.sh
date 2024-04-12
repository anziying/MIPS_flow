TOP_MODULE=MIPS_Core
vcs -f ./filenames -kdb -lca -l test.log +v2k -debug_all -full64
./simv
./simv -gui