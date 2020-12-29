@echo off

rem Aliases for ahmaddynugroho, only for cmd
rem december 29, 2020

rem files
doskey alias=nvim %userprofile%/dotfiles/alias.cmd
doskey ffcfg=nvim %userprofile%/scoop/shims/ff.cfg

rem listing
doskey l=fd -d 1
doskey la=fd -H -d 1

rem git
doskey g=git status
doskey gl=git log --oneline --graph
doskey gc=git commit -m "$*"
doskey gpush=git push
doskey gpull=git pull

rem directory
doskey cd=cd /d $*
doskey ..=cd ..
doskey ...=cd ../..
doskey h=cd /d %userprofile%
doskey a=cd /d %userprofile%/AppData
doskey d=cd /d D:
doskey e=cd /d E:
doskey f=cd /d F:

rem rclone
doskey rc=rclone copy $1 $2

rem neovim
doskey n=nvim $*
doskey nc=nvim -u NONE $*
doskey nd=cd %userprofile%/AppData/Local/nvim
