# vim: ft=zsh

alias sd="if [ -f ./script/dbconsole ]; then ./script/dbconsole; else rails db; fi"
alias s3=/usr/local/bin/s3cmd

alias bb="afplay /System/Library/Sounds/Glass.aiff"

alias h=heroku
alias hh="heroku help"
alias aria='aria2c -s 10 -x 10 -k 1M'

alias vm=VBoxManage
alias tf=terraform

function itermtheme() {
    (cd ~/d/; wget "https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/$1.itermcolors")
    open ~/d/"$1".itermcolors
}

#alias e=exercism
#alias :e=vim
alias :e="emacs -nw"
alias e="emacsclient -a emacsnox -t"


ku="/Applications/Kube-Solo.app/Contents/Resources/"
k=kubectl
