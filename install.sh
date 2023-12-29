#!/bin/bash

create_link() {
    local source_file=$1
    local destination_file=$2

    # ln fails if the full directory path doesn't exist
    mkdir -p $(dirname $2)

    if [ ! -f "$destination_file" ]; then
        ln -s "$source_file" "$destination_file"
        echo "Linked $destination_file"
    else
        echo "$destination_file already present so skipping"
    fi
}

create_link "$(pwd)/vimrc" "$HOME/.vimrc"
create_link "$(pwd)/init.vim" "$HOME/.config/nvim/init.vim"
create_link "$(pwd)/zshrc" "$HOME/.zshrc"
