set breakpoint pending on
set disassembly-flavor intel
set commands echo "refresh\n" | gdb-remote -ex "flushregs" -ex "show reg" -ex "show stack" -ex "info threads"

