#!/usr/bin/sh

export EDITOR=nvim
export TERM="xterm-256color"
export WM="xfce4"
export WM_EXEC="startxfce4"

export WORK_DIRS="$HOME/code/"
export PROJECT_DIRS="$HOME/code/"

export COLORTERM="truecolor"
export TERMINAL="st"
export TERMINAL_PROG="st"
export EXPLORER="yazi"
export GREP_OPTIONS='--color=auto'
export GREP_COLORS='mt=1;32'
export CLICOLOR=1
export READER="zathura"
export VISUAL="nvim"
export CODEEDITOR="nvim"
export BROWSER="google-chrome-stable"

export PAGER="nvimpager"


export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="$HOME/.cache/runtime/"
export XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DOCUMENTS_DIR="$HOME/docs"
export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pictures"
export XDG_PUBLICSHARE_DIR="$HOME/public"
export XDG_TEMPLATES_DIR="$HOME/templates"
export XDG_VIDEOS_DIR="$HOME/videos"

export XDG_CODE_DIR="$HOME/code"         # Made-up. Used for your code or cloned
export XDG_PROGRAMS_DIR="$HOME/programs" # Made-up. Used for compiling daily drive programs

export XDG_CURRENT_DESKTOP="$WM"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


# Generate LS_COLORS https://geoff.greer.fm/lscolors/
# Or using `vivid` program
# Using POSIX-compliant shell syntax

# Set editor

# Handle TMUX environment
if [ -n "$TMUX" ]; then
  # export TERM="screen-256color"
  # export TERM="tmux-256color" # Either this or alacritty works on alacritty
  # export TERM="xterm-256color"
  # export TERM=alacritty
  # export TERM=rxvt-256color
  # export TERM="xterm-256color"
fi

export TMUX_TMPDIR="$XDG_RUNTIME_DIR"

# Avoid duplicates in history
export HISTCONTROL=ignoredups:erasedups
# Set history file
export HISTFILE="$XDG_DATA_HOME/history"
if [ -n "$TMUX_PANE" ]; then
    HISTFILE="$XDG_DATA_HOME/history/history_tmux_$(echo "$TMUX_PANE" | cut -c 2-)"
fi


export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.

#
# Make themes be dark (edit: for now the files being under ~/.config is enough to pick up the themes)
# So we're leaving this uncomment just in case any problem were to arrive we can easily force some themes again
# But tbf that might mess up the cursor theme, because it's distinct form the overall theme.
#
# Gtk
# export GTK2_RC_FILES="$XDG_DATA_HOME/themes/dark/gtk-2.0/gtkrc"
# export GTK_THEME="Adwaita:dark"
# QT
# export QT_QPA_PLATFORMTHEME="gtk2" # Have QT use gtk2 theme.
# export QT_STYLE_OVERRIDE=adwaita-dark
export QT_QPA_EGLFS_HIDECURSOR=0

export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export KODI_DATA="$XDG_DATA_HOME/kodi"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export FLUTTERPATH="$XDG_DATA_HOME/flutter"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export UNISON="$XDG_DATA_HOME/unison"
export MBSYNCRC="$XDG_CONFIG_HOME/mbsync/config"
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export PYTHONUSERBASE="$XDG_DATA_HOME/python/modules/"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"

# Other program settings:
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"

export MOZ_USE_XINPUT2="1" # Mozilla smooth scrolling/touchpads.
export AWT_TOOLKIT="MToolkit wmname LG3D" # May have to install wmname
export _JAVA_AWT_WM_NONREPARENTING=1 # Fix for Java applications in dwm
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export ANDROID_HOME="$XDG_DATA_HOME/android/sdk"

export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"

export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"

############################################
######## WAYLAND WITH NVIDIA THINGS ########
############################################
export WLR_NO_HARDWARE_CURSORS=1
export GDK_SCALE=1

export XCURSOR_SIZE=26
export XCURSOR_THEME=Bibata-Modern-Ice
export XCURSOR_PATH="$XDG_CONFIG_HOME/icons/"
############################################
############################################
############################################

export EASYOCR_MODULE_PATH="$XDG_CONFIG_HOME/EasyOCR"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup/"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export GOPATH="$XDG_DATA_HOME/go"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export KERAS_HOME="${XDG_STATE_HOME}/keras"
export PYTHONSTARTUP="$HOME/python/pythonrc"

# NOTE: Use programs_dir for compiling manually and having hte source code
export ODIN_ROOT="$XDG_PROGRAMS_DIR/Odin/"
export VMODULES="$XDG_DATA_HOME/vmodules"


# export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview" # separate opts for history widget

export MANPAGER="less -R --use-color"
export LESS="R --use-color"
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"



safe_source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/src/exports/path.sh"

# Generate LS_COLORS https://geoff.greer.fm/lscolors/
# Or using `vivid` program
# if command -v vivid >/dev/null 2>&1; then
#     export LS_COLORS="$(vivid generate rose-pine)"
# else
#     export LS_COLORS='bd=38;5;68:ca=38;5;17:cd=38;5;113;1:di=38;5;30:do=38;5;127:ex=38;5;208;1:pi=38;5;126:fi=0:ln=target:mh=38;5;222;1:no=0:or=48;5;196;38;5;232;1:ow=38;5;220;1:sg=48;5;3;38;5;0:su=38;5;220;1;3;100;1:so=38;5;197:st=38;5;86;48;5;234:tw=48;5;235;38;5;139;3:*LS_COLORS=48;5;89;38;5;197;1;3;4;7:*README=38;5;220;1:*LICENSE=38;5;220;1:*COPYING=38;5;220;1:*INSTALL=38;5;220;1:*COPYRIGHT=38;5;220;1:*AUTHORS=38;5;220;1:*HISTORY=38;5;220;1:*CONTRIBUTORS=38;5;220;1:*PATENTS=38;5;220;1:*VERSION=38;5;220;1:*NOTICE=38;5;220;1:*CHANGES=38;5;220;1:*.log=38;5;190:*.txt=38;5;253:*.etx=38;5;184:*.info=38;5;184:*.markdown=38;5;184:*.md=38;5;184:*.mkd=38;5;184:*.nfo=38;5;184:*.pod=38;5;184:*.tex=38;5;184:*.textile=38;5;184:*.json=38;5;178:*.msg=38;5;178:*.pgn=38;5;178:*.rss=38;5;178:*.xml=38;5;178:*.yml=38;5;178:*.RData=38;5;178:*.rdata=38;5;178:*.cbr=38;5;141:*.cbz=38;5;141:*.chm=38;5;141:*.djvu=38;5;141:*.pdf=38;5;141:*.PDF=38;5;141:*.docm=38;5;111;4:*.doc=38;5;111:*.docx=38;5;111:*.eps=38;5;111:*.ps=38;5;111:*.odb=38;5;111:*.odt=38;5;111:*.rtf=38;5;111:*.odp=38;5;166:*.pps=38;5;166:*.ppt=38;5;166:*.pptx=38;5;166:*.ppts=38;5;166:*.pptxm=38;5;166;4:*.pptsm=38;5;166;4:*.csv=38;5;78:*.ods=38;5;112:*.xla=38;5;76:*.xls=38;5;112:*.xlsx=38;5;112:*.xlsxm=38;5;112;4:*.xltm=38;5;73;4:*.xltx=38;5;73:*cfg=1:*conf=1:*rc=1:*.ini=1:*.viminfo=1:*.pcf=1:*.psf=1:*.git=38;5;197:*.gitignore=38;5;240:*.gitattributes=38;5;240:*.gitmodules=38;5;240:*.awk=38;5;172:*.bash=38;5;172:*.bat=38;5;172:*.BAT=38;5;172:*.sed=38;5;172:*.sh=38;5;172:*.zsh=38;5;172:*.vim=38;5;172:*.ahk=38;5;41:*.py=38;5;41:*.pl=38;5;208:*.PL=38;5;160:*.t=38;5;114:*.msql=38;5;222:*.mysql=38;5;222:*.pgsql=38;5;222:*.sql=38;5;222:*.tcl=38;5;64;1:*.r=38;5;49:*.R=38;5;49:*.gs=38;5;81:*.asm=38;5;81:*.cl=38;5;81:*.lisp=38;5;81:*.lua=38;5;81:*.moon=38;5;81:*.c=38;5;81:*.C=38;5;81:*.h=38;5;110:*.H=38;5;110:*.tcc=38;5;110:*.c++=38;5;81:*.h++=38;5;110:*.hpp=38;5;110:*.hxx=38;5;110:*.ii=38;5;110:*.M=38;5;110:*.m=38;5;110:*.cc=38;5;81:*.cs=38;5;81:*.cp=38;5;81:*.cpp=38;5;81:*.cxx=38;5;81:*.cr=38;5;81:*.go=38;5;81:*.f=38;5;81:*.for=38;5;81:*.ftn=38;5;81:*.s=38;5;110:*.S=38;5;110:*.rs=38;5;81:*.sx=38;5;81:*.hi=38;5;110:*.hs=38;5;81:*.lhs=38;5;81:*.pyc=38;5;240:*.css=38;5;125;1:*.less=38;5;125;1:*.sass=38;5;125;1:*.scss=38;5;125;1:*.htm=38;5;125;1:*.html=38;5;125;1:*.jhtm=38;5;125;1:*.mht=38;5;125;1:*.eml=38;5;125;1:*.mustache=38;5;125;1:*.coffee=38;5;074;1:*.java=38;5;074;1:*.js=38;5;074;1:*.jsm=38;5;074;1:*.jsm=38;5;074;1:*.jsp=38;5;074;1:*.php=38;5;81:*.ctp=38;5;81:*.twig=38;5;81:*.vb=38;5;81:*.vba=38;5;81:*.vbs=38;5;81:*Makefile=38;5;155:*MANIFEST=38;5;243:*pm_to_blib=38;5;240:*.am=38;5;242:*.in=38;5;242:*.hin=38;5;242:*.scan=38;5;242:*.m4=38;5;242:*.old=38;5;242:*.out=38;5;242:*.SKIP=38;5;244:*.diff=48;5;197;38;5;232:*.patch=48;5;197;38;5;232;1:*.bmp=38;5;97:*.tiff=38;5;97:*.tif=38;5;97:*.TIFF=38;5;97:*.cdr=38;5;97:*.gif=38;5;97:*.ico=38;5;97:*.jpeg=38;5;97:*.JPG=38;5;97:*.jpg=38;5;97:*.nth=38;5;97:*.png=38;5;97:*.psd=38;5;97:*.xpm=38;5;97:*.ai=38;5;99:*.eps=38;5;99:*.epsf=38;5;99:*.drw=38;5;99:*.ps=38;5;99:*.svg=38;5;99:*.avi=38;5;114:*.divx=38;5;114:*.IFO=38;5;114:*.m2v=38;5;114:*.m4v=38;5;114:*.mkv=38;5;114:*.MOV=38;5;114:*.mov=38;5;114:*.mp4=38;5;114:*.mpeg=38;5;114:*.mpg=38;5;114:*.ogm=38;5;114:*.rmvb=38;5;114:*.sample=38;5;114:*.wmv=38;5;114:*.3g2=38;5;115:*.3gp=38;5;115:*.gp3=38;5;115:*.webm=38;5;115:*.gp4=38;5;115:*.asf=38;5;115:*.flv=38;5;115:*.ts=38;5;115:*.ogv=38;5;115:*.f4v=38;5;115:*.VOB=38;5;115;1:*.vob=38;5;115;1:*.3ga=38;5;137;1:*.S3M=38;5;137;1:*.aac=38;5;137;1:*.au=38;5;137;1:*.dat=38;5;137;1:*.dts=38;5;137;1:*.fcm=38;5;137;1:*.m4a=38;5;137;1:*.mid=38;5;137;1:*.midi=38;5;137;1:*.mod=38;5;137;1:*.mp3=38;5;137;1:*.mp4a=38;5;137;1:*.oga=38;5;137;1:*.ogg=38;5;137;1:*.opus=38;5;137;1:*.s3m=38;5;137;1:*.sid=38;5;137;1:*.wma=38;5;137;1:*.ape=38;5;136;1:*.aiff=38;5;136;1:*.cda=38;5;136;1:*.flac=38;5;136;1:*.alac=38;5;136;1:*.midi=38;5;136;1:*.pcm=38;5;136;1:*.wav=38;5;136;1:*.wv=38;5;136;1:*.wvc=38;5;136;1:*.afm=38;5;66:*.fon=38;5;66:*.fnt=38;5;66:*.pfb=38;5;66:*.pfm=38;5;66:*.ttf=38;5;66:*.otf=38;5;66:*.PFA=38;5;66:*.pfa=38;5;66:*.7z=38;5;40:*.a=38;5;40:*.arj=38;5;40:*.bz2=38;5;40:*.gz=38;5;40:*.rar=38;5;40:*.tar=38;5;40:*.tgz=38;5;40:*.xz=38;5;40:*.zip=38;5;40:*.zoo=38;5;40:*.apk=38;5;215:*.deb=38;5;215:*.jad=38;5;215:*.jar=38;5;215:*.cab=38;5;215:*.pak=38;5;215:*.pk3=38;5;215:*.vdf=38;5;215:*.vpk=38;5;215:*.bsp=38;5;215:*.dmg=38;5;215:*.r00=38;5;239:*.r01=38;5;239:*.r02=38;5;239:*.r03=38;5;239:*.r04=38;5;239:*.r05=38;5;239:*.r06=38;5;239:*.r07=38;5;239:*.r08=38;5;239:*.r09=38;5;239:*.r10=38;5;239:*.r100=38;5;239:*.r101=38;5;239:*.r102=38;5;239:*.r103=38;5;239:*.r104=38;5;239:*.r105=38;5;239:*.r106=38;5;239:*.r107=38;5;239:*.r108=38;5;239:*.r109=38;5;239:*.r11=38;5;239:*.r110=38;5;239:*.r111=38;5;239:*.r112=38;5;239:*.r113=38;5;239:*.r114=38;5;239:*.r115=38;5;239:*.r116=38;5;239:*.r12=38;5;239:*.r13=38;5;239:*.r14=38;5;239:*.r15=38;5;239:*.r16=38;5;239:*.r17=38;5;239:*.r18=38;5;239:*.r19=38;5;239:*.r20=38;5;239:*.r21=38;5;239:*.r22=38;5;239:*.r25=38;5;239:*.r26=38;5;239:*.r27=38;5;239:*.r28=38;5;239:*.r29=38;5;239:*.r30=38;5;239:*.r31=38;5;239:*.r32=38;5;239:*.r33=38;5;239:*.r34=38;5;239:*.r35=38;5;239:*.r36=38;5;239:*.r37=38;5;239:*.r38=38;5;239:*.r39=38;5;239:*.r40=38;5;239:*.r41=38;5;239:*.r42=38;5;239:*.r43=38;5;239:*.r44=38;5;239:*.r45=38;5;239:*.r46=38;5;239:*.r47=38;5;239:*.r48=38;5;239:*.r49=38;5;239:*.r50=38;5;239:*.r51=38;5;239:*.r52=38;5;239:*.r53=38;5;239:*.r54=38;5;239:*.r55=38;5;239:*.r56=38;5;239:*.r57=38;5;239:*.r58=38;5;239:*.r59=38;5;239:*.r60=38;5;239:*.r61=38;5;239:*.r62=38;5;239:*.r63=38;5;239:*.r64=38;5;239:*.r65=38;5;239:*.r66=38;5;239:*.r67=38;5;239:*.r68=38;5;239:*.r69=38;5;239:*.r69=38;5;239:*.r70=38;5;239:*.r71=38;5;239:*.r72=38;5;239:*.r73=38;5;239:*.r74=38;5;239:*.r75=38;5;239:*.r76=38;5;239:*.r77=38;5;239:*.r78=38;5;239:*.r79=38;5;239:*.r80=38;5;239:*.r81=38;5;239:*.r82=38;5;239:*.r83=38;5;239:*.r84=38;5;239:*.r85=38;5;239:*.r86=38;5;239:*.r87=38;5;239:*.r88=38;5;239:*.r89=38;5;239:*.r90=38;5;239:*.r91=38;5;239:*.r92=38;5;239:*.r93=38;5;239:*.r94=38;5;239:*.r95=38;5;239:*.r96=38;5;239:*.r97=38;5;239:*.r98=38;5;239:*.r99=38;5;239:*.zx00=38;5;239:*.zx01=38;5;239:*.zx02=38;5;239:*.zx03=38;5;239:*.zx04=38;5;239:*.zx05=38;5;239:*.zx06=38;5;239:*.zx07=38;5;239:*.zx08=38;5;239:*.zx09=38;5;239:*.zx10=38;5;239:*.zx11=38;5;239:*.zx12=38;5;239:*.zx13=38;5;239:*.zx14=38;5;239:*.zx15=38;5;239:*.zx16=38;5;239:*.zx17=38;5;239:*.zx18=38;5;239:*.zx19=38;5;239:*.zx20=38;5;239:*.zx21=38;5;239:*.zx22=38;5;239:*.zx25=38;5;239:*.zx26=38;5;239:*.zx27=38;5;239:*.zx28=38;5;239:*.zx29=38;5;239:*.zx30=38;5;239:*.zx31=38;5;239:*.zx32=38;5;239:*.zx33=38;5;239:*.zx34=38;5;239:*.zx35=38;5;239:*.zx36=38;5;239:*.zx37=38;5;239:*.zx38=38;5;239:*.zx39=38;5;239:*.zx40=38;5;239:*.zx41=38;5;239:*.zx42=38;5;239:*.zx43=38;5;239:*.zx44=38;5;239:*.zx45=38;5;239:*.zx46=38;5;239:*.zx47=38;5;239:*.zx48=38;5;239:*.zx49=38;5;239:*.zx50=38;5;239:*.zx51=38;5;239:*.zx52=38;5;239:*.zx53=38;5;239:*.zx54=38;5;239:*.zx55=38;5;239:*.zx56=38;5;239:*.zx57=38;5;239:*.zx58=38;5;239:*.zx59=38;5;239:*.zx60=38;5;239:*.zx61=38;5;239:*.zx62=38;5;239:*.zx63=38;5;239:*.zx64=38;5;239:*.zx65=38;5;239:*.zx66=38;5;239:*.zx67=38;5;239:*.zx68=38;5;239:*.zx69=38;5;239:*.zx69=38;5;239:*.zx70=38;5;239:*.zx71=38;5;239:*.zx72=38;5;239:*.zx73=38;5;239:*.zx74=38;5;239:*.zx75=38;5;239:*.zx76=38;5;239:*.zx77=38;5;239:*.zx78=38;5;239:*.zx79=38;5;239:*.zx80=38;5;239:*.zx81=38;5;239:*.zx82=38;5;239:*.zx83=38;5;239:*.zx84=38;5;239:*.zx85=38;5;239:*.zx86=38;5;239:*.zx87=38;5;239:*.zx88=38;5;239:*.zx89=38;5;239:*.zx90=38;5;239:*.zx91=38;5;239:*.zx92=38;5;239:*.zx93=38;5;239:*.zx94=38;5;239:*.zx95=38;5;239:*.zx96=38;5;239:*.zx97=38;5;239:*.zx98=38;5;239:*.zx99=38;5;239:*.zx100=38;5;239:*.zx101=38;5;239:*.zx102=38;5;239:*.zx103=38;5;239:*.zx104=38;5;239:*.zx105=38;5;239:*.zx106=38;5;239:*.zx107=38;5;239:*.zx108=38;5;239:*.zx109=38;5;239:*.zx110=38;5;239:*.zx111=38;5;239:*.zx112=38;5;239:*.zx113=38;5;239:*.zx114=38;5;239:*.zx115=38;5;239:*.zx116=38;5;239:*.z00=38;5;239:*.z01=38;5;239:*.z02=38;5;239:*.z03=38;5;239:*.z04=38;5;239:*.z05=38;5;239:*.z06=38;5;239:*.z07=38;5;239:*.z08=38;5;239:*.z09=38;5;239:*.z10=38;5;239:*.z11=38;5;239:*.z12=38;5;239:*.z13=38;5;239:*.z14=38;5;239:*.z15=38;5;239:*.z16=38;5;239:*.z17=38;5;239:*.z18=38;5;239:*.z19=38;5;239:*.z20=38;5;239:*.z21=38;5;239:*.z22=38;5;239:*.z25=38;5;239:*.z26=38;5;239:*.z27=38;5;239:*.z28=38;5;239:*.z29=38;5;239:*.z30=38;5;239:*.z31=38;5;239:*.z32=38;5;239:*.z33=38;5;239:*.z34=38;5;239:*.z35=38;5;239:*.z36=38;5;239:*.z37=38;5;239:*.z38=38;5;239:*.z39=38;5;239:*.z40=38;5;239:*.z41=38;5;239:*.z42=38;5;239:*.z43=38;5;239:*.z44=38;5;239:*.z45=38;5;239:*.z46=38;5;239:*.z47=38;5;239:*.z48=38;5;239:*.z49=38;5;239:*.z50=38;5;239:*.z51=38;5;239:*.z52=38;5;239:*.z53=38;5;239:*.z54=38;5;239:*.z55=38;5;239:*.z56=38;5;239:*.z57=38;5;239:*.z58=38;5;239:*.z59=38;5;239:*.z60=38;5;239:*.z61=38;5;239:*.z62=38;5;239:*.z63=38;5;239:*.z64=38;5;239:*.z65=38;5;239:*.z66=38;5;239:*.z67=38;5;239:*.z68=38;5;239:*.z69=38;5;239:*.z69=38;5;239:*.z70=38;5;239:*.z71=38;5;239:*.z72=38;5;239:*.z73=38;5;239:*.z74=38;5;239:*.z75=38;5;239:*.z76=38;5;239:*.z77=38;5;239:*.z78=38;5;239:*.z79=38;5;239:*.z80=38;5;239:*.z81=38;5;239:*.z82=38;5;239:*.z83=38;5;239:*.z84=38;5;239:*.z85=38;5;239:*.z86=38;5;239:*.z87=38;5;239:*.z88=38;5;239:*.z89=38;5;239:*.z90=38;5;239:*.z91=38;5;239:*.z92=38;5;239:*.z93=38;5;239:*.z94=38;5;239:*.z95=38;5;239:*.z96=38;5;239:*.z97=38;5;239:*.z98=38;5;239:*.z99=38;5;239:*.z100=38;5;239:*.z101=38;5;239:*.z102=38;5;239:*.z103=38;5;239:*.z104=38;5;239:*.z105=38;5;239:*.z106=38;5;239:*.z107=38;5;239:*.z108=38;5;239:*.z109=38;5;239:*.z110=38;5;239:*.z111=38;5;239:*.z112=38;5;239:*.z113=38;5;239:*.z114=38;5;239:*.z115=38;5;239:*.z116=38;5;239:*.part=38;5;239:*.dmg=38;5;124:*.iso=38;5;124:*.bin=38;5;124:*.nrg=38;5;124:*.qcow=38;5;124:*.sparseimage=38;5;124:*.toast=38;5;124:*.vcd=38;5;124:*.vmdk=38;5;124:*.accdb=38;5;60:*.accde=38;5;60:*.accdr=38;5;60:*.accdt=38;5;60:*.db=38;5;60:*.localstorage=38;5;60:*.mdb=38;5;60:*.mde=38;5;60:*.sqlite=38;5;60:*.typelib=38;5;60:*.nc=38;5;60:*.pacnew=38;5;33:*.un~=38;5;241:*.orig=38;5;241:*.BUP=38;5;241:*.bak=38;5;241:*.o=38;5;241:*.rlib=38;5;241:*.swp=38;5;244:*.swo=38;5;244:*.tmp=38;5;244:*.sassc=38;5;244:*.pid=38;5;248:*.state=38;5;248:*lockfile=38;5;248:*.err=38;5;160;1:*.error=38;5;160;1:*.stderr=38;5;160;1:*.dump=38;5;241:*.stackdump=38;5;241:*.zcompdump=38;5;241:*.zwc=38;5;241:*.pcap=38;5;29:*.cap=38;5;29:*.dmp=38;5;29:*.allow=38;5;112:*.deny=38;5;196:*.service=38;5;45:*@.service=38;5;45:*.socket=38;5;45:*.swap=38;5;45:*.device=38;5;45:*.mount=38;5;45:*.automount=38;5;45:*.target=38;5;45:*.path=38;5;45:*.timer=38;5;45:*.snapshot=38;5;45:*.application=38;5;116:*.cue=38;5;116:*.description=38;5;116:*.directory=38;5;116:*.m3u=38;5;116:*.m3u8=38;5;116:*.md5=38;5;116:*.properties=38;5;116:*.sfv=38;5;116:*.srt=38;5;116:*.theme=38;5;116:*.torrent=38;5;116:*.urlview=38;5;116:*.asc=38;5;192;3:*.bfe=38;5;192;3:*.enc=38;5;192;3:*.gpg=38;5;192;3:*.signature=38;5;192;3:*.sig=38;5;192;3:*.p12=38;5;192;3:*.pem=38;5;192;3:*.pgp=38;5;192;3:*.asc=38;5;192;3:*.enc=38;5;192;3:*.sig=38;5;192;3:*.32x=38;5;213:*.cdi=38;5;213:*.fm2=38;5;213:*.rom=38;5;213:*.sav=38;5;213:*.st=38;5;213:*.a00=38;5;213:*.a52=38;5;213:*.A64=38;5;213:*.a64=38;5;213:*.a78=38;5;213:*.adf=38;5;213:*.atr=38;5;213:*.gb=38;5;213:*.gba=38;5;213:*.gbc=38;5;213:*.gel=38;5;213:*.gg=38;5;213:*.ggl=38;5;213:*.ipk=38;5;213:*.j64=38;5;213:*.nds=38;5;213:*.nes=38;5;213:*.sms=38;5;213:*.pot=38;5;7:*.pcb=38;5;7:*.mm=38;5;7:*.pod=38;5;7:*.gbr=38;5;7:*.spl=38;5;7:*.scm=38;5;7:*.Rproj=38;5;11:*.sis=38;5;7:*.1p=38;5;7:*.3p=38;5;7:*.cnc=38;5;7:*.def=38;5;7:*.ex=38;5;7:*.example=38;5;7:*.feature=38;5;7:*.ger=38;5;7:*.map=38;5;7:*.mf=38;5;7:*.mfasl=38;5;7:*.mi=38;5;7:*.mtx=38;5;7:*.pc=38;5;7:*.pi=38;5;7:*.plt=38;5;7:*.pm=38;5;7:*.rb=38;5;7:*.rdf=38;5;7:*.rst=38;5;7:*.ru=38;5;7:*.sch=38;5;7:*.sty=38;5;7:*.sug=38;5;7:*.t=38;5;7:*.tdy=38;5;7:*.tfm=38;5;7:*.tfnt=38;5;7:*.tg=38;5;7:*.vcard=38;5;7:*.vcf=38;5;7:*.xln=38;5;7:'
# fi

# NOTE: This file is generated from installer.py
safe_source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/src/exports/ls_colors.sh"


