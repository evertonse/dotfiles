#!/usr/bin/python3
import sys
import os
from pathlib import Path
from shutil import copytree, rmtree as rmdir, copy as cp
from glob import glob
from functools import partial

cpdir = partial(copytree, dirs_exist_ok=True)
home = Path.home()
installs = ["dotfiles", 'dotdirs']

def dotdirs():
    dirs = [
        *set(glob('.config/*/')) - {'./.config/nvchad/'},
        './autosetup/',
        './.scripts/',
        './.local/bin'
    ]

    for dir in dirs:
        dir = Path(dir)
        if (
            autoyes
            or input(
                f"About to copy and overwrite src={dir} into dest={Path(home,dir)} [y/n]?"
            ).lower()
            == "y"
        ):
            cpdir(dir, Path(home, dir))
    
def dotfiles():
    files = [
        "./.bashrc",
        "./.gdbinit",
        "./.zshrc",
    ]


    for f in files:
        f = Path(f)
        if (
            autoyes
            or input(
                f"About to copy and overwrite src={f} into dest={Path(home,f)} [y/n]?"
            ).lower()
            == "y"
        ):
            cp(f, Path(home, f))


autoyes = False


def main():
    global autoyes
    argc = len(sys.argv)
    if argc > 1 and sys.argv[1].lower() == "-y":
        print("Chose -y, will not prompt and will override config ")
        autoyes = True

    if os.name == "nt":
        print("Windows not supported for automatically install")
        exit(69)

    print("Which one do you wish to install ? ")
    for key, value in enumerate(installs):
        print(f"{key+1} : {value}")
    which = installs[int(input())-1]

    if which == "dotdirs":
        dotdirs()
    elif which == "dotfiles":
        dotfiles()


if __name__ == "__main__":
    main()

