from functools import partial
import os
import sys
from shutil import copytree
from pathlib import Path

copydir = partial(copytree,dirs_exist_ok=True)


def install(silent=False):
    if os.name in {'nt'}:
        vscode_path =  Path(os.getenv('APPDATA'), "Code/")

    src = Path( Path(__file__).parent, "User") 
    dst = Path(vscode_path, "User")

    if silent == False:
        print(f"INFO: Copy and overwritting files \t\t\nfrom: {src} \t\t\nto: {dst}\t\n")

        result = input("Continue ? [y/n]")

        if result.lower() in {'yes','y'}:
            copydir(src=src, dst=dst)
    else:
        copydir(src=src, dst=dst)


def main():
   if len(sys.argv) >= 2: 
        if sys.argv[1].lower() in {'-y'}:
            install(silent=True)
        else:
            install(silent=False)
            
if __name__ == '__main__':
    main()