setopt prompt_subst

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' stagedstr ' staged'
zstyle ':vcs_info:*' unstagedstr ' unstaged'
zstyle ':vsc_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes true
zstyle ':vcs_info:git*' actionformats '[%b|%a] '
zstyle ':vcs_info:git*' formats '%F{8}%c%u%m%f [%F{13}%b%f]'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st git-stash git-remotebranch

# Add indicator for untracked files
function +vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
        hook_com[unstaged]+=' untracked'
    fi
}

# Get remote branch name and commit count difference
function +vi-git-st() {
    local ahead behind remote
    local -a gitstatus

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    if [[ -n ${remote} ]] ; then
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

        hook_com[branch]="${hook_com[branch]} ${remote}"

        if ! [[ -z ${gitstatus} ]]; then
            hook_com[branch]+=" ${(j:/:)gitstatus}"
        fi
    fi
    
}

# Show count of stashed changes
function +vi-git-stash() {
    local -a stashes

    if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
        stashes=$(git stash list 2>/dev/null | wc -l | tr -d '[:space:]')
        hook_com[misc]+=" (${stashes} stashed)"
    fi
}

precmd () { vcs_info }


#PROMPT='%F{8}%D{%H:%M:%S}%f [%F{5}%n%f@%F{5}%M%f] %~ 
PROMPT='[%F{5}%n%f@%F{5}%M%f] %~ 
$ '
RPROMPT='${vcs_info_msg_0_}'
