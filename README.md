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
sudo pacman -Syu git github-cli lazygit vim neovim python-pynvim tmux nodejs npm php composer python starship zoxide fzf fd ripgrep bat
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
sudo npm i -g pnpm

# lsp
sudo pacman -S lua-language-server stylua
sudo pnpm add -g typescript typescript-language-server intelephense emmet-ls prettier prettier-init @fsouza/prettierd
```
