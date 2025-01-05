```bash
# install kanata
# https://github.com/jtroo/kanata/releases

# dependencies
sudo apt update
sudo add-apt-repository universe # for libfuse2 for running .appimage
sudo apt install xsel zip unzip libfuse2 build-essential ripgrep gh bat

# setup git
gh auth login
git config --global user.name "ahmaddynugroho"
git config --global user.email "ahmaddwi700@gmail.com"

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# get tmux.appimage in https://github.com/nelsonenzo/tmux-appimage/releases

# setup fnm for neovim dependencies
curl -fsSL https://fnm.vercel.app/install | bash
fnm install 22

# get neovim from https://github.com/neovim/neovim/releases/
git clone https://github.com/ahmaddynugroho/nvim ~/.config/nvim

# setup dotfile
cd ~
mkdir repo
cd repo
git clone https://github.com/ahmaddynugroho/dotfiles
cd ~
ln -s $(pwd)/repo/dotfiles/.tmux.conf $(pwd)/.tmux.conf
echo "source ~/repo/dotfiles/bashrc.bash" >> ~/.bashrc
```
