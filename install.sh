#!/bin/bash

set -Euo pipefail

# root is required to link to /usr/local/bin
sudo -v

create_link() {
    local source_file=$1
    local destination_file=$2

    # ln fails if the full directory path doesn't exist
    mkdir -p $(dirname $2)

    if [ ! -f "$destination_file" ]; then
        sudo ln -s "$source_file" "$destination_file"
        echo "Linked $destination_file"
    else
        echo "$destination_file already present so skipping"
    fi
}

create_link "$(pwd)/ghostty/config" "$HOME/.config/ghostty/config"

create_link "$(pwd)/vim/vimrc" "$HOME/.vimrc"
create_link "$(pwd)/vim/init.vim" "$HOME/.config/nvim/init.vim"
create_link "$(pwd)/vim/nvim-tree-config.lua" "$HOME/.config/nvim/nvim-tree-config.lua"

create_link "$(pwd)/zsh/zshrc" "$HOME/.zshrc"
create_link "$(pwd)/scripts/aws_profile_fzf.sh" "/usr/local/bin/aws_profile_fzf.sh"

create_link "$(pwd)/k9s/transparent.yaml" "$HOME/Library/Application Support/k9s/skins/transparent.yaml"
create_link "$(pwd)/k9s/config.yaml" "$HOME/Library/Application Support/k9s/config.yaml"
