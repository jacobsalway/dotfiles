if [ ! -f $HOME/.vimrc ]; then
    ln -s $(pwd)/vimrc $HOME/.vimrc
    echo "Linked $HOME/.vimrc"
else
    echo "$HOME/.vimrc already present so skipping"
fi

if [ ! -f $HOME/.zshrc ]; then
    ln -s $(pwd)/zshrc $HOME/.zshrc
    echo "Linked $HOME/.zshrc"
else
    echo "$HOME/.zshrc already present so skipping"
fi
