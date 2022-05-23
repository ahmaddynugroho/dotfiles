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
sudo pacman -Syu gcc git github-cli lazygit vi neovim python-pynvim tmux nodejs npm php composer python starship zoxide fzf fzy fd ripgrep
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
sudo npm i -g pnpm
sudo pnpm add -g prettierd
```
