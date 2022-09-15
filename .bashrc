# efficient bash_history. ignoreboth is actually just like doingignorespace
# ignorespace:ignoredups and that along with erasedups gets the job done
export HISTCONTROL=ignoreboth:erasedups
PROMPT_COMMAND="history -a;$PROMPT_COMMAND" # realtime bash history

# fzf
export FZF_DEFAULT_COMMAND='fd --type f -a'
export FZF_CTRL_T_COMMAND='fd --type f -a'
export FZF_ALT_C_COMMAND='fd --type d -a'
source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

# System
export EDITOR="nvim"
alias upmir="sudo reflector -p http,https -f 7 -l 15 --save /etc/pacman.d/mirrorlist"
alias sudo="sudo "
alias S="sudo "
alias b="nvim ~/.bashrc"
alias bs="source ~/.bashrc"
alias v="lazygit"
alias a="nvim"
alias ai="cd ~/dotfiles/nvim && nvim init.lua"
alias t="tmux"
alias py="python"

# Path
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export PATH="$PATH:$HOME/.local/zig"
export PATH="$PATH:$HOME/.local/zls/bin/"

# Yay
alias upmir="sudo reflector -p http,https -f 7 -l 15 --save /etc/pacman.d/mirrorlist"
alias y="yay"
alias ys="yay -S"
alias yss="yay -Ss"

# dir
alias l="ls -l --color"
alias lt="ls -lt --color"
alias la="ls -la --color"
alias lat="ls -lta --color"
alias ..="cd .."
alias ...="cd ../.."
alias ep="explorer.exe ."
alias h="cd ~"
alias r="cd ~/repo"
mkcdir() {
  mkdir "$1"
  cd "$1"
}

# nodejs
alias p="pnpm"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# zoxide
eval "$(zoxide init bash)"

# tmux
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux
#fi

# prompt
eval "$(starship init bash)"

# TMUX
## don't waste time if $TMUX environemnt variable is set
#[ -z $TMUX ] || return
#
## don't start a tmux session if current shell is not connected to a terminal
#pts=$(tty) || return
#
## find out processes connected to master pseudoterminal
#for ptm in $(fuser /dev/ptmx 2>/dev/null)
#do
    ## ignore process if it's not a tmux server
    #grep -q tmux /proc/$ptm/comm || continue
    ## number of bytes already read by tmux server
    #rchar_old=$(awk '/rchar/ {print $2}' /proc/$ptm/io)
    ## write out 1000 bytes to current slave pseudoterminal terminal
    #dd bs=1 count=1000 if=/dev/zero of=$pts &>/dev/null
    ## read number of bytes again and find difference
    #diff=$(( $(awk '/rchar/ {print $2}' /proc/$ptm/io) - rchar_old ))
    ## if it equals 1000, current terminal is connected to tmux server
    ## however diff comes greater than 1000 most of the times
    #[ $diff -ge 1000 ] && return
#done
#
## start or attach to a tmux session
#echo 'Press any key to interrupt tmux session.'
#read -st1 key && return
#
## connect to a detached session if exists for current user
#session=($(tmux list-sessions 2>/dev/null | sed -n '/(attached)/!s/:.*r//p'))
#[ -z $session ] || exec tmux a -t ${session[0]}
#
## start a new session after all
#exec tmux

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/civbag/.local/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/civbag/.local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/civbag/.local/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/civbag/.local/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

