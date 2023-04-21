# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$XDG_STATE_HOME/zsh/history

zstyle :compinstall filename '$XDG_CONFIG_HOME/zsh/zshrc'

autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments
setopt no_list_ambiguous
setopt nocaseglob
setopt inc_append_history # save history entires as soon as they're entered
setopt share_history # share history between different instances of shell
setopt auto_list
setopt auto_menu
setopt completealiases

# Vi mode
bindkey -e
export KEYTIMEOUT=1 # instant exit

# Edit line in vim buffer ctrl-v
# autoload edit-command-line; zle -N edit-command-line
# bindkey '^v' edit-command-line
# # Enter vim buffer from normal mode
# autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line

# # Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'left' vi-backward-char
# bindkey -M menuselect 'down' vi-down-line-or-history
# bindkey -M menuselect 'up' vi-up-line-or-history
# bindkey -M menuselect 'right' vi-forward-char
# # Fix backspace bug when switching modes
# bindkey "^?" backward-delete-char
# # Enable searching through history
# bindkey '^R' history-incremental-pattern-search-backward

# # Change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select

# # ci", ci', ci`, di", etc
# autoload -U select-quoted
# zle -N select-quoted
# for m in visual viopp; do
#   for c in {a,i}{\',\",\`}; do
#     bindkey -M $m $c select-quoted
#   done
# done

# # ci{, ci(, ci<, di{, etc
# autoload -U select-bracketed
# zle -N select-bracketed
# for m in visual viopp; do
#   for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
#     bindkey -M $m $c select-bracketed
#   done
# done
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# precmd() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Environmental variables
source ~/.zshenv

# clean-up
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

# fzf key-bindings
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

eval "$(starship init zsh)"
eval "$(thefuck --alias)"
eval "$(zoxide init zsh)"

# install and uninstall pkg with ctrl+p
function install-pkg {
	pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
}
function uninstall-pkg {
	pacman -Qeq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns
}
zle -N install-pkg
zle -N uninstall-pkg
bindkey -M viins '^P' install-pkg
bindkey -M viins '^O' uninstall-pkg

# Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
