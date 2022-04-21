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
alias S="sudo"
alias upmir="sudo reflector -p http,https -f 7 -l 15 --save /etc/pacman.d/mirrorlist"
alias b="nvim ~/.bashrc"
alias bs="source ~/.bashrc"
alias ch="chezmoi"

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

# ultralist
alias u="ultralist"
alias ul="ultralist l"
alias ulc="script -qc \"ultralist l\" < /dev/null | sort -t @ -k 2,2"
alias ulp="script -qc \"ultralist l\" < /dev/null | sort -t + -k 2,2"
alias uf="script -qc \"ultralist l\" < /dev/null | fzf --ansi"
alias uc="ultralist l due:agenda group:context"
alias up="ultralist l due:agenda group:project"
alias tod="ultralist l group:project due:tod"
alias tom="ultralist l group:project due:tom"
alias mon="ultralist l group:project due:mon"
alias tue="ultralist l group:project due:tue"
alias wed="ultralist l group:project due:wed"
alias thu="ultralist l group:project due:thu"
alias fri="ultralist l group:project due:fri"
alias sat="ultralist l group:project due:sat"
alias sun="ultralist l group:project due:sun"
alias c="ultralist l completed:tod"

# exercism
alias exercism="ex"
exd() {
  ex download -e "$1" -t "$2"
}

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
