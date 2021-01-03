@echo off

rem Aliases for ahmaddynugroho, only for cmd
rem december 29, 2020

rem change default prompt for this session
prompt $E[0;36m$D$S$T$H$H$H$S$B$S$P$_$$$S$E[0;37m

rem files
doskey alias=nvim %userprofile%/dotfiles/alias.cmd

rem listing
doskey l=fd -d 1
doskey la=fd -H -d 1

rem git
doskey g=git status
doskey ga=git add $*
doskey gl=git log --oneline --graph
doskey gc=git commit -m $*
doskey gpush=git push
doskey gpull=git pull

rem directory
doskey ex=explorer $*
doskey cd=cd /d $*
doskey ..=cd ..
doskey ...=cd ../..
doskey h=cd /d %userprofile%
doskey a=cd /d %userprofile%/AppData
doskey d=cd /d D:
doskey e=cd /d E:
doskey f=cd /d F:
doskey z=exit

rem rclone
doskey rc=rclone copy $1 $2 -P

rem neovim
doskey n=nvim $*
doskey nc=nvim -u NONE $*
doskey nd=cd %userprofile%/AppData/Local/nvim

rem swipl
doskey pl=swipl -s $*
