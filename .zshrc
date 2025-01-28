# fnm node version manager
eval "$(fnm env --use-on-cd --shell zsh)"

# Add golang to path if it is installed
if [ -d "/usr/local/go/bin" ]; then
    export PATH=$PATH:/usr/local/go/bin
fi

# Make sure .local/bin is added in path, scripts live here
export PATH="$HOME/.local/bin:$PATH"

# Stop insecure messages
ZSH_DISABLE_COMPFIX="true"

# k9s config path
export K9S_CONFIG_DIR="$HOME/.config/k9s"

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Tokyonight for fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#283457 \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"
  
# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Disable use of ! and !! for commands
# This can interfere when ! is used in other commands, just disabling as I dont use ! or !!
setopt NO_HIST_EXPAND

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
zsh-syntax-highlighting
zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# vi mode
bindkey -v
# fix small delay when entering vi mode
# https://www.reddit.com/r/vim/comments/60jl7h/zsh_vimode_no_delay_entering_normal_mode/
KEYTIMEOUT=1
# ctrl-p & ctrl-n to behave like arrow keys
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search
bindkey '^R' history-incremental-search-backward

#####
# Yank to system register (https://unix.stackexchange.com/questions/25765/pasting-from-clipboard-to-vi-enabled-zsh-or-bash-shell)
function x11-clip-wrap-widgets() {
    local copy_or_paste=$1
    shift

    local copy_cmd='xclip -in -selection clipboard'
    local paste_cmd='xclip -out -selection clipboard'
    if [[ "$(uname)" == "Darwin" ]]; then
        copy_cmd='pbcopy'
        paste_cmd='pbpaste'
    fi

    for widget in "$@"; do
        local wrapper_func="_x11-clip-wrapped-$widget"
        if [[ $copy_or_paste == "copy" ]]; then
            eval "
            function $wrapper_func() {
                zle .$widget
                echo -n \$CUTBUFFER | $copy_cmd
            }
            "
        else
            eval "
            function $wrapper_func() {
                CUTBUFFER=\$($paste_cmd)
                zle .$widget
            }
            "
        fi

        zle -N $widget $wrapper_func
    done
}

local copy_widgets=(
    vi-yank vi-yank-eol vi-delete vi-backward-kill-word vi-change-whole-line
)
local paste_widgets=(
    vi-put-{before,after}
)

# NB: can atm. only wrap native widgets
x11-clip-wrap-widgets copy $copy_widgets
x11-clip-wrap-widgets paste  $paste_widgets
#####
##### END Yank to system register

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

alias python=/usr/bin/python3
# Alias for kitty set tab title
alias ct='kitty @ set-tab-title'
# Alias for nvim, dir level
alias n='nvim .'
# Alias for lazygit tui
alias lg='lazygit'
# Alias for personal nvim config, dir level
alias astro='NVIM_APPNAME=astro_nvim nvim .'
# Alias for personal nvim config
alias astronvim='NVIM_APPNAME=astro_nvim nvim'
# Alias fzf dir search and navigate
# . important else it will execute in subshell
alias f='. fzf_dev.sh'
# Open kitty tab in selected dir from search
# alias ft='. fzf_dev_tab.sh'
# # TMUX
#tmux attach
alias ta='tmux attach'
# tmux sessionizer with fzf
bindkey -s '^f' "~/.config/bin/tmux-sessionizer.sh\n"
# # TMUX END
# zelli sessionizer with fzf
# bindkey -s '^f' "zellij-sessionizer.sh\n"


# load .bash_profile
if [ -f $HOME/.bash_profile ]; then 
    . $HOME/.bash_profile;
fi

## ZELLIJ
# chpwd_functions is a special array that holds functions
# which are automatically executed whenever you change directories using cd or similar commands
# This changes ZELLIJ tab name on change
# https://www.reddit.com/r/zellij/comments/10skez0/does_zellij_support_changing_tabs_name_according/

# zellij_tab_name_update() {
#     if [[ -n $ZELLIJ ]]; then
#         local current_dir=$PWD
#         if [[ $current_dir == $HOME ]]; then
#             current_dir="~"
#         else
#             current_dir=${current_dir##*/}
#         fi
#         command nohup zellij action rename-tab $current_dir >/dev/null 2>&1
#     fi
# }
#
# zellij_tab_name_update
# chpwd_functions+=(zellij_tab_name_update)

## ZELLIJ END

# starship prompt
eval "$(starship init zsh)"
