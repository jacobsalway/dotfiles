if [ ! -f $HOME/.vimrc ]; then
    ln -s $(pwd)/vimrc $HOME/.vimrc
fi

if [ ! -f $HOME/.zshrc ]; then
    ln -s $(pwd)/zshrc $HOME/.zshrc
fi
