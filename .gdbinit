set commands echo "refresh\n" | gdb-remote -ex "flushregs" -ex "show reg" -ex "show stack" -ex "info threads"
