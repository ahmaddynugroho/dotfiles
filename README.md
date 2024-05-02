```PowerShell
New-Item -Path ~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Value (Get-Item ".\Microsoft.PowerShell_profile.ps1").FullName
```

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/civbag/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install zoxide fzf lazygit neovim
/home/linuxbrew/.linuxbrew/opt/fzf/install # keybindings
echo 'eval "$(zoxide init bash)"' >> .bashrc
source ~/.bashrc
```

```bash
sudo apt install git fzf zoxide neovim xcape gh
echo 'source ~/repo/dotfiles/bashrc.bash' >> .bashrc
git config --global user.name "ahmaddynugroho"
git config --global user.email "ahmaddwi700@gmail.com"
gh auth login
gh auth setup-git
```

```bash
# setup anki in debian
sudo apt install libxcb-xinerama0 libxcb-cursor0 libxcb-xcccm4 libxcb-keysyms1 libnss3 mpv
```
