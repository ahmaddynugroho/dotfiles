```bash
# Basics
passwd
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
useradd -m -G wheel -s /bin/bash civbag
passwd civbag
arch --default-user civbag # from powershell, won't work on cmd
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Syy archlinux-keyring

# Coding stuff
sudo pacman -Syu --needed git github-cli base-devel python python-pip lazygit neovim tmux nvm php composer starship zoxide fzf fd ripgrep bat

# Git
gh auth login
git config --global user.name "Ahmad D. Y. Nugroho"
git config --global user.email "ahmaddwi700@gmail.com"

# Yay: Managing AUR
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd .. && rm -rf yay-bin

# Setup some dependencies
pip install pynvim
yay -S nvm
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.bashrc
. .bashrc

# Node
nvm install node --latest-npm
npm i -g pnpm

# LSPs
sudo pacman -S lua-language-server stylua
pnpm setup && . .bashrc
pnpm add -g typescript typescript-language-server intelephense emmet-ls prettier prettier-init @fsouza/prettierd

# NeoVim Setup
git clone http://github.com/ahmaddynugroho/dotfiles -C ~/dotfiles
ln -s ~/dotfiles/nvim/ ~/.config/nvim
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
mv ~/.bashrc ~/.bashrc.bak && ln -s ~/dotfiles/.bashrc ~/.bashrc
nvim -c "source ~/.config/nvim/lua/plugins.lua" # Packer auto install
```
