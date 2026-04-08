#!/usr/bin/env bash
set -xe

go() {
    local base="$1"
    python3 organize.py "${base}.gi" > "${base}.cvars"
}

file1="boot"
go "$file1"

file2="kaiboot"
go "$file2"
diff "${file1}.cvars" "${file2}.cvars" > diff.txt || true

go "old"
go "kai"
go "kai2"
go "spooky"

