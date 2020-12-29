## About

scoop, alias, dual-key-remap, fzf, fd, neovim, rclone

## List

1. scoop + git

   Please set git username afterward (powershell) <br>
   `Set-ExecutionPolicy AllSigned; Set-ExecutionPolicy RemoteSigned -scope CurrentUser; iwr -useb get.scoop.sh | iex; scoop install git; scoop bucket add extras`

2. cmd alias

   `cd /d %userprofile% && git clone https://github.com/ahmaddynugroho/dotfiles && cd dotfiles && alias.reg`

3. dual-key-remap

   `mklink "%appdata%/Microsoft/Windows/Start Menu/Programs/Startup/dual-key-remap" "%userprofile%/dotfiles/dual-key-remap/dual-key-remap.exe"`

4. fzf, fd, rclone

   `scoop install fzf fd rclone`

5. nvim

   `process`
