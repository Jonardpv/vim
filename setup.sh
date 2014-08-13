#!/bin/bash

if [ -f ~/.vimrc ]; then
	rm ~/.vimrc
fi


cd ~/.vim
if [ -d bundle ]; then
    rm -rf bundle after ftdetect
fi

mkdir -p bundle after/plugin ftdetect
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
pushd bundle/YouCompleteMe/
./install.sh
popd
ln -s ~/.vim/bundle/UltiSnips/after/plugin/UltiSnips_after.vim ~/.vim/after/plugin/
ln -s ~/.vim/bundle/UltiSnips/ftdetect/* ~/.vim/ftdetect/
ln -s ~/.vim/vimrc ~/.vimrc

echo
echo "Installed and configured .vim, have fun."
