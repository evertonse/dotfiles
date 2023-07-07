import os
import sys
def test(string, cmd):
    y = input("are you on debian? [y/n]").lower()
    if y == 'y':
        os.system("source ./debian/git.sh")


y = input("are you on debian? [y/n]").lower()
if y == 'y':
    os.system("source ./debian/git.sh")

