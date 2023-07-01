#!/bin/python3
import sys
import os
from pathlib import Path
import vscode.install as vs
from shutil import copytree as copydir, rmtree as rmdir, copy as cp
from glob import glob 

home = Path.home()
installs = {
    1: "vscode",
    2: "dotfiles",
}

def dotfiles():
    files = ['./.bashrc', './.tmux.conf']
    for f in files:
        f = Path(f)
        if input(f'About to copy and overwrite src={f} into dest={Path(home,f)} [y/n]?').lower() == 'y':
            cp(f, Path(home,f))

def main():
    if os.name == 'nt':
        print('Windows not supported for automatically install')
        exit(69)

    print("Which one do you wish to install ? ")
    for key,value in installs.items():
        print(f'{key} : {value}')

    which = installs[int(input())]
    if which == "vscode":
        vs.install()

    elif which == 'dotfiles':
        dotfiles()

main()
