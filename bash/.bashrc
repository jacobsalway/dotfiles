#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export COLOR_NC='\e[0m'
export COLOR_WHITE='\e[1;37m'
export COLOR_GRAY='\e[38;5;243m'
export COLOR_LIGHT_BLUE='\e[38;5;111m'
export COLOR_GIT='\e[38;5;159m'

export TERM='xterm-256color'

# get current git branch
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# set nice terminal prefix
PS1="\[${COLOR_NC}\][\[${COLOR_LIGHT_BLUE}\]\u@\h\[${COLOR_NC}\]] \[${COLOR_NC}\]\w\[${COLOR_GIT}\]\$(parse_git_branch)\n\[${COLOR_GRAY}\]\t \[${COLOR_NC}\]$ "

# helpful aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
