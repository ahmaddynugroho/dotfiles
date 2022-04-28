```bash
# using archwsl on wsl2 (install using scoop)
passwd
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
adduser -m -G wheel -s /bin/bash civbag
passwd civbag
arch.exe --default-user civbag # from powershell
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Syy archlinux-keyring
sudo pacman -Syu gcc git github-cli lazygit vi neovim tmux nodejs npm php composer python starship zoxide fzf fzy fd ripgrep
```
