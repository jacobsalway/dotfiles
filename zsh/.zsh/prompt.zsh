source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

setopt prompt_subst

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

autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr ' staged'
zstyle ':vcs_info:*' unstagedstr ' unstaged'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '[%b|%a] '
zstyle ':vcs_info:*' formats \
  '%F{8}%c%u%f%m [%F{13}%b%f]'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st git-stash git-remotebranch
zstyle ':vcs_info:*' enable git

function +vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
        hook_com[unstaged]+=' untracked'
    fi
}


function +vi-git-remotebranch() {
    local remote

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    # The first test will show a tracking branch whenever there is one. The
    # second test, however, will only show the remote branch's name if it
    # differs from the local one.
    if [[ -n ${remote} ]] ; then
    #if [[ -n ${remote} && ${remote#*/} != ${hook_com[branch]} ]] ; then
        hook_com[branch]="${hook_com[branch]} ${remote}"
    fi
}

function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    # for git prior to 1.7
    # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    ahead=$(echo "${ahead}" | tr -d '[:space:]')
    (( $ahead )) && gitstatus+=( "+${ahead}" )

    # for git prior to 1.7
    # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
    behind=$(echo "${behind}" | tr -d '[:space:]')
    (( $behind )) && gitstatus+=( "-${behind}" )
    
    if ! [[ -z ${gitstatus} ]]; then
        hook_com[branch]+=" ${(j:/:)gitstatus}"
    fi
}

# Show count of stashed changes
function +vi-git-stash() {
    local -a stashes

    if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
        stashes=$(git stash list 2>/dev/null | wc -l)
        hook_com[misc]+=" (${stashes} stashed)"
    fi
}


precmd () { vcs_info }


PROMPT='%F{8}%D{%H:%M:%S}%f [%F{5}%n%f@%F{5}%M%f] %~ 
$ '
RPROMPT='${vcs_info_msg_0_}'
