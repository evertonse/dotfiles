#!/usr/bin/python3

import sys
import os
from pathlib import Path
from shutil import copytree, rmtree as rmdir, copy as cpfile, move as mv
from glob import glob
from functools import partial
import subprocess

print_err  = lambda *x: print("\x1b[1m\x1b[31m"+"error: "+"\033[0m", *x)
print_info = lambda *x: print("\x1b[30;1m"     +"info:  "+"\033[0m",  *x)
print_okay = lambda *x: print("\033[92m"       +"okay:  "+"\033[0m",  *x)
     
def ordinal(n: int):
    if 11 <= (n % 100) <= 13:
        suffix = 'th'
    else:
        suffix = ['th', 'st', 'nd', 'rd', 'th'][min(n % 10, 4)]
    return str(n) + suffix


def cmd_std_out(command, autoyes=False):
    """Run a shell command and return the output."""
    if autoyes or getch(f"{command} [y/n]?").lower() == "y":
        result = subprocess.run(
            command, shell=True, capture_output=True, text=True, check=True
        )
        return result.stdout.strip()


def win_path_exits(path):
    response = cmd_std_out(f"powershell.exe Test-Path {path}")
    if response == "True":
        return True
    elif response == "False":
        return False
    else:
        print(f"Test-Path returned unkown response `{response}`, exiting...")
        exit(0)


def windows_username():
    """Get the Windows username from within WSL."""
    return cmd_std_out('cmd.exe /c "echo %USERNAME%"')


def getch(x=None):
    import termios
    import sys
    import tty

    if x is not None:
        print(x)
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    try:
        tty.setraw(fd)
        ch = sys.stdin.read(1)  # This number represents the length
        if ch == "\x03":  # ASCII value for Ctrl+C
            print("Ctrl+C detected, exiting...")
            exit(0)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
    return ch


cpdir = partial(copytree, dirs_exist_ok=True)


def cp(src, dst):
    src, dst = Path(src), Path(dst)
    print_info(f"src={src} -> dst={dst}")
    if src.is_dir():
        cpdir(src, dst)
    elif src.exists():
        cpfile(src, dst)
    else:
        print_info(f"Source file {src} doesn't exist")


def write(file_path, content):
    # Open the file in write mode, which will override if it exists
    with open(file_path, 'w') as file:
        file.write(content)



BIG_YES = False


def yes_or_no(x) -> bool:
    global BIG_YES

    if BIG_YES == True:
        return BIG_YES

    phrase = f"{x} [(y)es/(n)o/(a)ll]?"
    c = getch(phrase).lower()
    while c not in {"y", "n", "yes", "no", "all", "a"}:
        c = getch(phrase).lower()
    BIG_YES = c.startswith("a")

    return BIG_YES or c.startswith("y")


home = Path.home()


error_count = 0
error_cmds  = list()
def cmd(x):
    global error_count
    if yes_or_no(x):
        ok = os.system(x)
        if ok != 0:
            error_count += 1
            error_cmds.append(x)
            print_err(f"Previous command has failed with error code {ok}.")


def remove_neovim():
    cmd(f"rm -rf {home}/.config/nvim")
    cmd(f"rm -rf {home}/.local/share/nvim")
    cmd(f"rm -rf {home}/.local/state/nvim")


def install_neovim():
    cmd(
        f"git clone https://github.com/evertonse/kickstart.nvim.git {home}/.config/nvim"
    )


def install_neovim_on_windows_from_wsl():
    win_user_name = windows_username()

    # This looks funny because we have a double scape situation,
    # this is run from the zsh shell instead of 9P protocol from wsl to /mnt/c (if we were to use shutil)
    # Below is a var that could be used with shutil instead of shell:
    #     win_home = f'/mnt/c/user/{win_user_name}/AppData/Local'
    win_home = f"C:\\\\Users\\\\{win_user_name}\\\\AppData\\\\Local"

    def remove_neovim_windows11():
        if win_path_exits(f"{win_home}\\\\nvim"):
            cmd(f"powershell.exe rm -Recurse -Force {win_home}\\\\nvim")
        if win_path_exits(f"{win_home}\\\\nvim-data"):
            cmd(f"powershell.exe rm -Recurse -Force {win_home}\\\\nvim-data")

    def install_neovim_windows11():
        cmd(
            f"powershell.exe git clone https://github.com/evertonse/kickstart.nvim.git {win_home}\\\\nvim"
        )

    remove_neovim_windows11()
    install_neovim_windows11()


def dotdirs():
    dirs = [
        *glob("./config/*"),
        *glob("./local/*"),
    ]

    links = {
        # NOTE: Every path is relative to $HOME/.config
        # Source                                Destination
        (f"{home}/.config/zsh/interactive.zsh", f"{home}/.config/zsh/.zshrc"),
        (f"{home}/.config/zsh/env.zsh",         f"{home}/.config/zsh/.zshenv"),
        (f"{home}/.config/zsh/login.zsh",       f"{home}/.config/zsh/.zprofile"),
        (f"{home}/.config/zsh/logout.zsh",      f"{home}/.config/zsh/.zlogout"),
        (f"{home}/.config/zsh/interactive.zsh", f"{home}/.zshrc"),
        (f"{home}/.config/zsh/interactive.zsh", f"{home}/.zshrc"),
        (f"{home}/.config/zsh/env.zsh",         f"{home}/.zshenv"),
        (f"{home}/.config/zsh/login.zsh",       f"{home}/.zprofile"),
        (f"{home}/.config/zsh/logout.zsh",      f"{home}/.zlogout"),
        (f"{home}/.config/X11/xinitrc",         f"{home}/.xinitrc"),
        # ("/usr/local/bin/nvim")


        (f"{home}/.config/kitty.0/", f"{home}/.config/kitty"),
        (f"{home}/.config/eww.XX/", f"{home}/.config/eww"),
        (f"{home}/.config/waybar.Zanius/", f"{home}/.config/waybar"),
        (f"{home}/.config/rofi.titus/", f"{home}/.config/rofi"),
    }

    copies = {
        # (f"{home}/.config/zsh/zshrc", f"{home}/.zshrc"),
    }

    for file in dirs:
        src = Path(file)
        dst = Path(home, f".{src}")
        if (
            autoyes
            or input(
                f"About to copy and overwrite src={file} into dest={Path(home,file)} [y/n]?"
            ).lower()
            == "y"
        ):
            # We put a dot '.' in front because we preserver the name config
            # but programs expect .config, got it?
            cp(src, dst)

    # cmd(f'sudo cp -rf ./config {Path(home, '.config')}')

    print(f">>--------Links--------\n")
    for src, dst in links:
        src = Path(src)
        dst = Path(dst)
        cmd(f"sudo rm -rf {dst} || rm -f {dst}")
        cmd(f"ln -sfT {src} {dst}")
    print(f"<<--------Links--------\n")

    print(f">>--------Copies--------\n")
    for src, dst in copies:
        src = Path(src)
        dst = Path(dst)
        cmd(f"sudo rm -rf {dst} || rm -f {dst}")
        cp(src, dst)
    print(f"<<--------Copies--------\n")

    cmd(f"sudo ln -sf /{home}/.local/include/* /usr/include")
    cmd(f"sudo cp -rf config/X11/xorg.conf.d/ /etc/X11/")
    cmd(f"sudo ln -sf /{home}/.local/include/* /usr/include")
    cmd(
        f"sudo ln -sfT  /{home}/.config/X11/xkb/symbols/br-excyber /usr/share/X11/xkb/symbols/br-excyber"
    )
    # cmd(f'setxkbmap -model br-abnt2 -layout br -option ""')
    # cmd('setxkbmap -model br-abnt2-excyber -layout br-excyber -option ""')
    # cmd(
    #     f"xkbcomp -w0 -I$HOME/.config/X11/xkb/ {home}/.config/X11/xkb/keymap/excyber-keymap $DISPLAY"
    # )
    cmd(f"chmod +x {home}/.local/bin/*")
    cmd(
        f"ln -sf {home}/.config/picom/picom.jonaburg.conf {home}/.config/picom/picom.conf"
    )


def dotrepos():
    remove_neovim()
    install_neovim()

    nvimpager = Path(home, "code", "rocks")
    cmd(
        f"git clone https://github.com/lucc/nvimpager {nvimpager} && cd {nvimpager} &&  make PREFIX=$HOME/.local install-no-man"
    )

    rocks = Path(home, "code", "rocks")
    cmd(
        f"git clone https://github.com/evertonse/rocks {rocks} && cd {rocks} && ./install.sh"
    )
    path = Path(home, "code", "dwm-flexipatch")
    cmd(
        f"git clone https://github.com/evertonse/dwm-flexipatch {path} && cd {path} && sudo make install"
    )


# def neovim():
#     neovim_path = Path(home,'code','neovim')
#     neovim_path.mkdir(parents=True, exist_ok=True)
#     if neovim_path.is_dir():
#         rmdir(neovim_path)
#     cmd(f"git clone  https://github.com/neovim/neovim {neovim_path}")
#     cmd(f"cd {neovim_path}")
#     cmd(f"make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install")


def dotfiles():
    files = [
        *glob("./.*"),
        "./pacman.conf",
        "./.gitconfig",
    ]

    cmd(f"sudo cp {Path('config','wsl.conf')} {Path('/etc', 'wsl.conf')}")
    for f in files:
        if f == "./pacman.conf":
            cmd(f"sudo cp {Path(f)} {Path('/etc', 'pacman.conf')}")
            continue
        if f == "./grub":
            cmd(f"sudo cp {Path(f)} {Path('/etc', 'default', 'grub')}")
            print(
                " to ensure the grub config is set use 'sudo grub-mkconfig -o /boot/grub/grub.cfg'"
            )
            continue

        f = Path(f)
        if f.is_dir():
            continue

        if (
            autoyes
            or input(
                # f'for sure this is not a dir isit : {f.is_dir()}'
                # +
                f"About to copy and overwrite src={f} into dest={Path(home,f)} [y/n]?"
            ).lower()
            == "y"
        ):
            cp(f, Path(home, f))

    dotdirs()

    out = cmd_std_out("./local/bin/toml2lscolors local/share/lscolors.toml", True)
    write(f'{home}/.config/shell/src/exports/ls_colors.sh', f'export LS_COLORS="{out}"')
    shell_interpret = [
        f'fast-theme {home}/.config/zsh/fast-syntax-highlighting/themes/default.ini',
        f'lscolors2toml > {home}/.config/yazi/ls_colors.toml',
    ]

    for shell_cmd in shell_interpret:
        cmd(f'zsh -i -c "{shell_cmd}"')


install_commands = [
    install_neovim_on_windows_from_wsl,
    dotfiles,
    dotrepos,
]

autoyes = False


def main():
    global autoyes
    # Sort the commands by their function name
    install_commands.sort(key=lambda x: x.__name__)
    assert len(install_commands) < 10

    argc = len(sys.argv)
    if argc > 1 and sys.argv[1].lower() == "-y":
        print("Chose -y, will not prompt and will override config ")
        autoyes = True

    if os.name == "nt":
        print("Windows not supported for automatic installation")
        exit(69)

    print("Which one do you wish to install?")
    for idx, cmd in enumerate(install_commands):
        print(f"{idx + 1} : {cmd.__name__.replace('_',' ')}")

    try:
        choice = int(getch()) - 1
    except:
        choice = -1

    if choice < 0 or choice >= len(install_commands):
        print("Invalid choice. Exiting.")
        exit(1)

    selected_command = install_commands[choice]
    selected_command()
    if error_count == 0:
        print_okay("Finished")
    else:
        print_info(
            f"Finished with {error_count} errors."
            + "\n\tThese are the failed commands:\n\t"
            + f"{'\n\t'.join(ordinal(i+1) + ": " + s for i,s in enumerate(error_cmds))}"
        )


if __name__ == "__main__":
    main()
