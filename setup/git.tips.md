# Squash commits into one
 how_many_commits_to_squase='3'
 ``$ rebase``

# Rebase

  `git rebase -i --rebase-merges --rerere-autoupdate HEAD~10`

- ``$ git checkout -b local_feature ``
- ``$ git commit -a -m "features"``

- to update everything from remote/main to local/main ``$ git checkout main && git pull  ``
- make local_feature rebased ``$ git checkout local_feature && git rebase main``
- make main rebased ``$ git checkout main && git rebase local_feature``
- push your new straight branch ``$ git push``

# Ricing (https://wiki.installgentoo.com/index.php/GNU/Linux_ricing)

- Distro: Arch (but sometimes Gentoo/Funtoo, Void Linux, Debian GNU/Linux, FreeBSD, or even OpenBSD);
- Window Manager: i3, Sway, Awesome, or dwm;
- Login/Display manager: Usually none;
- File Manager: ranger, mc, nnn, or none;
- Terminal Emulator: rxvt-unicode or st;
- Shell: zsh + oh-my-zsh, fish, or bash;
- OS information: Neofetch, Screenfetch or Archey;
- font: DejaVu, Inconsolata, terminus, or Tewi;
- Music player: mpd + ncmpcpp or ncmpc, or cmus;
- Video player: mpv;
- IRC client: weechat or irssi;
- Screen capture (screenshot): scrot, maim, or import (part of imagemagick);
- Image viewer/desktop wallpaper display: feh, sxiv;
- Screen recorder: see below (some casuals also use Byzanz);
- Streaming: FFmpeg (which includes FFserver if you want to host the stream);
- Video conversion: FFmpeg (including WebM or GIF creation);
- Text editor: Vim (or Neovim), Emacs, Nano, or Sublime Text.
