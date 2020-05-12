dotfiles
========


The install.sh script will backup existing dotfiles

Pre-requisites
==============

  * Install Vundle to manage VIM plugins

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  * Remove unnecessary plugins from ~/dotfiles/bundles.vim, then install all bundles in one go

    vim +PluginInstall +qall

  * Install FZF to replace bash history (CTRL+R) and add interactive file searches 
    https://github.com/junegunn/fzf

    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install


Additional tools and plugin helpers
===================================

apt install -y yamllint


