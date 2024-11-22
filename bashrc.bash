alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
alias t="tmux"
alias v="lazygit"
alias n="nvim"
alias rgctags="rg --files | ctags -R --links=no -L -"

export VISUAL=nvim
export EDITOR="$VISUAL"

PATH=$PATH:/usr/local/bin
PATH=$PATH:~/.local/bin

eval "$(zoxide init bash)"
eval "$(fnm env --use-on-cd --shell bash)"
