#!/bin/bash
set -Euo pipefail

# sudo is required to link to /usr/local/bin
sudo -v || exit 1

FORCE=false

for arg in "$@"; do
  case "$arg" in
    -f|--force)
      FORCE=true
      ;;
  esac
done

create_link() {
    local source_file=$1
    local destination_file=$2

    mkdir -p "$(dirname "$destination_file")"

    if [ -L "$destination_file" ] || [ -e "$destination_file" ]; then
        if [ "$FORCE" = true ]; then
            echo "Forcefully relinking $destination_file"
            sudo rm -rf "$destination_file"
        else
            echo "$destination_file already exists, skipping (use --force to overwrite)"
            return
        fi
    fi

    sudo ln -s "$source_file" "$destination_file"
    echo "Linked $destination_file to $source_file"
}

create_link "$(pwd)/zsh/zshrc" "$HOME/.zshrc"

create_link "$(pwd)/ghostty/config" "$HOME/.config/ghostty/config"
create_link "$(pwd)/tmux/tmux.conf" "$HOME/.tmux.conf"

create_link "$(pwd)/nvim/init.lua" "$HOME/.config/nvim/init.lua"

create_link "$(pwd)/k9s/transparent.yaml" "$HOME/Library/Application Support/k9s/skins/transparent.yaml"
create_link "$(pwd)/k9s/config.yaml" "$HOME/Library/Application Support/k9s/config.yaml"

create_link "$(pwd)/claude/settings.json" "$HOME/.claude/settings.json"
create_link "$(pwd)/claude/statusline.sh" "$HOME/.claude/statusline.sh"
create_link "$(pwd)/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
create_link "$(pwd)/claude/keybindings.json" "$HOME/.claude/keybindings.json"

create_link "$(pwd)/codex/config.toml" "$HOME/.codex/config.toml"

create_link "$(pwd)/scripts/aws_profile_fzf.sh" "/usr/local/bin/aws_profile_fzf.sh"
