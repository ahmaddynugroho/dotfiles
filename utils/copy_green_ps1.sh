copy_green_ps1() {
  echo "PS1=\"\[\e[32m\]\u@\h:\w\$\[\e[0m\]\n> \"" | xsel --clipboard
}
