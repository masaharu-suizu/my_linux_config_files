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

mkdir -p /tmp/`date +%Y%m%d`
SSH_AGENT_FILE="/tmp/`date +%Y%m%d`/.ssh-agent"
SSH_PRIVATE_KEY="${HOME}/.ssh/id_rsa"
if [ ! -f "${SSH_PRIVATE_KEY}" ]; then
    ssh-keygen -t rsa -b 4096
fi
test -f "${SSH_AGENT_FILE}" && source "${SSH_AGENT_FILE}"
if ! ssh-add -l > /dev/null 2>&1; then
    ssh-agent > "${SSH_AGENT_FILE}"
    source "${SSH_AGENT_FILE}"
    ssh-add "${SSH_PRIVATE_KEY}"
fi

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
