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
alias ni="nvim ~/dotfiles/nvim/init.lua"

# Path
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

# Yay
alias upmir="sudo reflector -p http,https -f 7 -l 15 --save /etc/pacman.d/mirrorlist"
alias y="yay"
alias ys="yay -S"
alias yss="yay -Ss"

# dir
alias l="ls --color"
alias lf="fd -d 1"
alias la="ls -a --color"
alias ..="cd .."
alias ...="cd ../.."
alias ep="explorer.exe ."
alias h="cd ~"
alias r="cd ~/repo"
alias k="cd /mnt/e/Kuliah"
mkcdir() {
  mkdir "$1"
  cd "$1"
}

# nodejs
alias p="pnpm"

# zoxide
eval "$(zoxide init bash)"

# tmux
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux
#fi

# prompt
eval "$(starship init bash)"

# TMUX
# don't waste time if $TMUX environemnt variable is set
[ -z $TMUX ] || return

# don't start a tmux session if current shell is not connected to a terminal
pts=$(tty) || return

# find out processes connected to master pseudoterminal
for ptm in $(fuser /dev/ptmx 2>/dev/null)
do
    # ignore process if it's not a tmux server
    grep -q tmux /proc/$ptm/comm || continue
    # number of bytes already read by tmux server
    rchar_old=$(awk '/rchar/ {print $2}' /proc/$ptm/io)
    # write out 1000 bytes to current slave pseudoterminal terminal
    dd bs=1 count=1000 if=/dev/zero of=$pts &>/dev/null
    # read number of bytes again and find difference
    diff=$(( $(awk '/rchar/ {print $2}' /proc/$ptm/io) - rchar_old ))
    # if it equals 1000, current terminal is connected to tmux server
    # however diff comes greater than 1000 most of the times
    [ $diff -ge 1000 ] && return
done

# start or attach to a tmux session
echo 'Press any key to interrupt tmux session.'
read -st1 key && return

# connect to a detached session if exists for current user
session=($(tmux list-sessions 2>/dev/null | sed -n '/(attached)/!s/:.*r//p'))
[ -z $session ] || exec tmux a -t ${session[0]}

# start a new session after all
exec tmux
