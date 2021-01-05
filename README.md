## Setup

1. Run `alias.reg`
2. Make `dual-key-remap.exe`'s shortcut in windows startup
3. Install `scoop`
4. Install `fzf` and `fd`
5. Clone [cx](https://github.com/ahmaddynugroho/cx) and add it to `PATH` (It's under rewriting process in rust, but the batch version still works)

### scoop + git

Please set git username afterward (powershell) <br>
`Set-ExecutionPolicy AllSigned; Set-ExecutionPolicy RemoteSigned -scope CurrentUser; iwr -useb get.scoop.sh | iex; scoop install git; scoop bucket add extras`

### windows startup dir

`%userprofile%/Microsoft/Windows/Start Menu/Programs/Startup`

### neovim config

https://github.com/ahmaddynugroho/nvim

#### Links

https://github.com/lukesampson/scoop<br>
https://github.com/ililim/dual-key-remap<br>
https://github.com/sharkdp/fd<br>
https://github.com/junegunn/fzf<br>
https://github.com/rclone/rclone<br>
https://github.com/ahmaddynugroho/cx
