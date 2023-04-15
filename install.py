from pathlib import Path
import vscode.install as vs
from glob import glob 

installs = {
    1: "vscode"
}

print("Which one do you wish to install ? ")
for key,value in installs.items():
    print(f'{key} : {value}')

which = installs[int(input())]
if which == "vscode":
    vs.install()


