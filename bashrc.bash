alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
alias t="tmux"
alias v="lazygit"
alias n="nvim"
alias rgctags="rg --files | ctags -R --links=no -L -"
alias bat=batcat

export VISUAL=nvim
export EDITOR="$VISUAL"
export PAGER=batcat

PATH=$PATH:/usr/local/bin
PATH=$PATH:~/.local/bin

eval "$(zoxide init bash)"
eval "$(fnm env --use-on-cd --shell bash)"

PS1="$PS1\n> "
