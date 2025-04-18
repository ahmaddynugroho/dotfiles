source ~/repo/dotfiles/utils/prompt_git_commit.sh
source ~/repo/dotfiles/utils/copy_green_ps1.sh

alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
alias t="tmux"
alias v="lazygit"
alias n="nvim"
alias rgctags="rg --files | ctags -R --links=no -L -"

export VISUAL=nvim
export EDITOR="$VISUAL"
export PAGER=bat

PATH=$PATH:/usr/local/bin
PATH=$PATH:~/.local/bin

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

if [ -f "$(command -v fzf)" ]; then
  eval "$(fzf --bash)"
fi

if [ -f "$(command -v zoxide)" ]; then
  eval "$(zoxide init bash)"
fi

if [ -f "$(command -v fnm)" ]; then
  eval "$(fnm env --use-on-cd --shell bash)"
fi

if [ -f "$(command -v pyenv)" ]; then
  eval "$(pyenv init - bash)"
  eval "$(pyenv virtualenv-init -)"
fi

PS1="$PS1\n> "
