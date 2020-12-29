## Description

Install scoop & git, then run alias.reg, then make dual-key-remap startup shortcut, then install fd & fzf & rclone using scoop

### scoop + git

Please set git username afterward (powershell) <br>
`Set-ExecutionPolicy AllSigned; Set-ExecutionPolicy RemoteSigned -scope CurrentUser; iwr -useb get.scoop.sh | iex; scoop install git; scoop bucket add extras`

### windows startup dir

`%userprofile%/Microsoft/Windows/Start Menu/Programs/Startup`

### neovim config

https://github.com/ahmaddynugroho/nvim

#### Credit

https://github.com/lukesampson/scoop
https://github.com/ililim/dual-key-remap
https://github.com/sharkdp/fd
https://github.com/junegunn/fzf
https://github.com/genotrance/ff
https://github.com/rclone/rclone
