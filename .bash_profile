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
