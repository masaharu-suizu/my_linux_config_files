source ${HOME}/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
PS1='\[\e]0;\u@\h: \w\a\]\[\033[01;32m\]\u@\H\[\033[00m\]:\[\033[01;35m\]\t\[\033[00m\]:\[\033[01;37m\]\w\[\033[00m\] $(__git_ps1 " (%s)") \$ '
