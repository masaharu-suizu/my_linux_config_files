# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

declare -a SERVER_LIST=($(grep 'HostName' ${HOME}/.ssh/config | awk {'print $2'}))

_ssh_completion(){
    local args=$(echo ${SSH_SERVER_LIST[@]})
    COMPREPLY=( `compgen -W "${args}" -- ${COMP_WORDS[COMP_CWORD]}` );
}
complete -F _ssh_completion ssh

if [ ! -f ${HOME}/git-completion.bash ]; then
    wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
fi
source ${HOME}/git-completion.bash

if [ ! -f ${HOME}/git-prompt.sh ]; then
    wget https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
fi
source ${HOME}/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

PROMPT_COMMAND='__git_ps1 "[\u@\h \w" "]\\\$ "'
