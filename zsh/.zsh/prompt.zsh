setopt prompt_subst

git_branch() {
    local name
    name=$(git branch 2>/dev/null | awk '/^\*/ { print $2 }')
    if ! [[ -z $name ]]; then
        echo "[%F{5}${name}%f]"
    fi
}

git_dirty() {
    local STATUS
    STATUS=$(command git status --porcelain --ignore-submodules -unormal 2> /dev/null | tail -n1)

    if [[ -n $STATUS ]]; then
        echo "* "
    fi
}

#PROMPT='%F{8}%D{%H:%M:%S}%f [%F{5}%n%f@%F{5}%M%f] %~ 
PROMPT='[%F{5}%n%f@%F{5}%M%f] %~ 
$ '
RPROMPT='$(git_dirty)$(git_branch)'
