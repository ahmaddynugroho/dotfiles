```PowerShell
New-Item -Path ~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Value (Get-Item ".\Microsoft.PowerShell_profile.ps1").FullName
```

```bash
sudo apt install git xcape
git config --global user.name "ahmaddynugroho"
git config --global user.email "ahmaddwi700@gmail.com"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "eval \"$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\"" >> /home/${$USER}/.bashrc
echo 'source ~/repo/dotfiles/bashrc.bash' >> /home/${$USER}/.bashrc
brew install zoxide fzf lazygit neovim gh tmux rg
source ~/.bashrc
gh auth login
gh auth setup-git

# setup anki in debian
sudo apt install libxcb-xinerama0 libxcb-cursor0 libxcb-xcccm4 libxcb-keysyms1 libnss3 mpv

# setup japanese ime
sudo apt install zenity fcitx5 fcitx5-mozc
im-config
```
