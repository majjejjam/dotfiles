# Add .scripts folder to PATH variable
export PATH=$HOME/.local/bin/:/home/majje/nedl/matlab_R2020b_glnxa64/bin/glnxa64:/home/majje/.cargo/bin/:/home/majje/.local/share/cargo/bin/:/home/majje/tizen-studio/tools/:/home/majje/tizen-studio/tools/ide/bin/:/opt/:~/Projekt/tree-sitter-lilypond/node_modules/.bin/:/home/majje/.config/emacs/bin/:$PATH
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export BLACKBOX_THEMES_DIR=$HOME/.var/app/com.raggesilver.BlackBox/data/blackbox/schemes
export JAVE_HOME=/usr/lib/jvm/java-19-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export DOOMDIR=$XDG_CONFIG_HOME/doom/

# Manage dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias vim="nvim"
alias gc="git clone"
alias lg="lazygit"
alias ld="lazygit -g ~/.dotfiles/ -w ~/"
alias p='pacman -Ssq | fzf -m --layout=reverse --preview="pacman --color=always -Si {}" --bind=space:toggle-preview | xargs -ro sudo pacman -S'
alias zotra="node ~/Projekt/zotra-cli/bin/index.js"

# Colors
alias ls="exa --group-directories-first --icons"
alias cat="bat"
alias sheet="npx msdl"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip --color=auto"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias bc="bc -ql"
alias grep="grep -i"
export LESS='-Ri --incsearch --use-color -Dd+r$Du+b'
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"

# Env dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_DIRS="/etc/xdg"

export EDITOR=emacsclient
export VISUAL=emacsclient

# Environmental variables
# neovim
# if (( $+commands[nvim] )); then
#     export EDITOR=nvim
#     export VISUAL=nvim
#     export MANPAGER='nvim +Man!'
#     export DIFFPROG='nvim -d'
# fi

# bat
# color=$(gsettings get org.gnome.desktop.interface color-scheme) 
if (( $+commands[bat] )); then
    export BAT_THEME=ansi
    export BAT_STYLE=plain
fi

export BROWSER=firefox
export MOZ_ENABLE_WAYLAND=1
export GDK_BACKEND=wayland
# export WINIT_UNIX_BACKEND=x11
export QT_STYLE_OVERRIDE=kvantum
# export QT_QPA_PLATFORMTHEME=gnome

# clean up ~
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh/"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export GNUPGHOME="~/.gnupg" # can't clean with protonvpn
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export CARGO_HOME="$XDG_DATA_HOME"/cargo 
# export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH" 
export OCTAVE_HISTFILE="$XDG_STATE_HOME/octave-hsts"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
# export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"

alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
alias wget="wget --hsts-file='$XDG_CACHE_HOME/wget-hsts'"

# fzf
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_DEFAULT_OPTS="--ansi --height 60%"

# nnn
# export NNN_BMS='d:~/doku;n:~/nedl;r:/;c:~/.config;b:~/bilder;w:~/bilder/walls;v:~/vids;u:~/progs/suckless/dwmajje;s:~/stud/ett/term/rep'
export NNN_PLUG='x:_chmod +x $nnn;f:finder;o:fzopen;i:imgthumb;w:imgview;z:suedit;v:vidthumb;b:bookmarks;E:suedit'
export NNN_TRASH=1
export NNN_OPS_PROG=1
export NNN_FALLBACK_OPENER=xdg-open
export NNN_OPTS="RgucQ"

# nethack
# export NETHACKOPTIONS="@~/.config/nethackrc"

# Hardware acceleration
export LIBVA_DRIVER_NAME=iHD
export VDPAU_DRIVER=va_gl
