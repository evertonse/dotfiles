# lifetime-config-files
dotfiles and +
- .linuxtips for frequently questioins I have
# github

Get Token
The first step in using tokens is to generate a token from the GitHub website. Note that it would be best practice to use different tokens for different computers/systems/services/tasks so that they can be easily managed.

To generate a token:

Log into GitHub
Click on your name / Avatar in the upper right corner and select Settings
On the left, click Developer settings
Select Personal access tokens and click Generate new token
Give the token a description/name and select the scope of the token
I selected repo only to facilitate pull, push, clone, and commit actions
Click the link Red more about OAuth scopes for details about the permission sets
Click Generate token
Copy the token – this is your new password!

Configure local GIT
Once we have a token, we need to configure the local GIT client with a username and email address. On a Linux machine, use the following commands to configure this, replacing the values in the brackets with your username and email.

git config --global user.name ""
git config --global user.email ""
git config -l
Clone from GitHub
Once GIT is configured, we can begin using it to access GitHub. In this example I perform a git clone command to copy a repository to the local computer. When prompted for the username and password, enter your GitHub username and the previously generated token as the password.


Configure Credential Caching
Lastly, to ensure the local computer remembers the token, we can enable caching of the credentials. This configures the computer to remember the complex token so that we dont have too.

git config --global credential.helper cache

export GCM_CREDENTIAL_CACHE_OPTIONS="--timeout 300"
# or
git config --global credential.cacheOptions "--timeout 300"
git config --global credential.credentialStore cacheclear the token from the local computer by running

git config --global --unset credential.helper

# WSL

### xorg
- donwload ``GWSL`` from microsoft store optionally ``X410``
- donwload Arch.zip from ``https://github.com/yuk7/ArchWSL``
- follow this guide ``https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/#initialize-keyring``
### pacman
- [user@PC-NAME]$ sudo pacman-key --init

- [user@PC-NAME]$ sudo pacman-key --populate

- [user@PC-NAME]$ sudo pacman -Sy archlinux-keyring

- [user@PC-NAME]$ sudo pacman -Su
- sudo pacman -S --needed base-devel

- sudo pacman -S archlinux-keyring && sudo pacman -Syu
- edit /etc/pacman.conf, add "ParallelDonwloads = 5"
- yay -S ttf-jetbrains-mono-nerd 3.0.2-1
- power level10k, and change to zsh
### shell 
- yay -S --noconfirm zsh
- yay -S --noconfirm zsh-theme-powerlevel10k-git
- echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
- chsh -s /usr/bin/zsh
- git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
- yay -S exa
- ps -p $$ check your shell with
### display manager (dont)
### xorg
- sudo pacman -S --noconfirm xorg

# Vim tips
- :g/<!-- [A-Z]\+[0-9]\+/norm $da<0P
- :read !ls *pdf

# USB / WIFI
- rfkill, to see if is blocked on a hardware level
- iwctl to connect to wifi
- nmtui also
- lspci -k 
- lsusb
- lspci -vnn 
