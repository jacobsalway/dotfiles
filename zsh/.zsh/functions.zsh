export MARKPATH=$HOME/.marks

function jump { 
	cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}

function mark { 
	mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}

function unmark { 
	rm -i "$MARKPATH/$1"
}

function marks {
	ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

function fo {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d \
        -print 2> /dev/null | fzf +m)
    cd $dir
}

function cd() {
  builtin cd "$@"

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./.env ]] ; then
        source ./.env/bin/activate
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
      fi
  fi
}
