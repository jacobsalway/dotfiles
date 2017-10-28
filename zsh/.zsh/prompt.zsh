function git_prompt_info {
    git branch 2>/dev/null | awk '/^\*/ { print $2 }'
}

function git_dirty {
    local FLAGS
    FLAGS=('--porcelain')
    local STATUS
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)

    if [[ -n $STATUS ]]; then
        echo "*"
    fi
}

PROMPT='[%F{6}%n%f@%F{6}%M%f] %~ %F{8}$(git_prompt_info)$(git_dirty)%f
$ '
RPROMPT='%F{8}%*%f'
