#!/bin/bash

function install_dotfiles() {
    GIT_PATH="samporapeli/dotfiles.git"

    echo Do you want to replace current dotfiles, just clone the repository for viewing or do nothing?
    echo -n "Type 'replace', 'clone' or 'exit': " 
    read INSTALL_TYPE

    if [ "$INSTALL_TYPE" = "replace" ] || [ "$INSTALL_TYPE" = "clone" ]; then
        echo -n "Clone repository over ssh? [Y/n] "
        read USE_SSH
        if [ "$USE_SSH" = "y" ] || [ "$USE_SSH" = "" ]; then
            GIT_PREFIX="git@github.com:"
        elif [ "$USE_SSH" = "n" ]; then
            GIT_PREFIX="https://github.com/"
        else
            echo Invalid input, exiting
            exit
        fi
        if [ "$INSTALL_TYPE" = "replace" ]; then
            function dotfiles () {
                /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/ $@
            }
            echo ".dotfiles" >> .gitignore
            dotfiles clone --bare $GIT_PREFIX$GIT_PATH $HOME/.dotfiles
            dotfiles config --local status.showUntrackedFiles no
        echo -n "Destroy previous configuration? This cannot be undone. [y/N] "
        read DESTROY_CONFIRMATION
        if [ "$DESTROY_CONFIRMATION" = "y" ]; then
            echo Copying files...
            dotfiles checkout
            echo Downloading git submodules...
            dotfiles submodule init
            dotfiles submodule update
        else
            echo Aborting...
            exit
        fi
        elif [ "$INSTALL_TYPE" = "clone" ]; then
            git clone $GIT_PREFIX$GIT_PATH
        fi
        echo -n "Install zsh? [Y/n] "
        read INSTALL_ZSH
        if [ "INSTALL_ZSH" = "" ] || [ "$INSTALL_ZSH" = "y" ] && command -v apt-get &> /dev/null; then
            echo Using apt-get to install zsh...
            sudo apt-get -y install zsh
        else
            echo apt-get not found. Please install zsh manually.
        fi
        echo -n "Install oh-my-zsh? (https://ohmyz.sh) [Y/n] "
        read OH_MY_ZSH
        if [ "$OH_MY_ZSH" = "" ] || [ "$OH_MY_ZSH" = "y" ]; then
            sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        fi
    elif [ "$INSTALL_TYPE" = "exit" ]; then
        exit
    else
        echo Invalid input, exiting
        exit
    fi
}
install_dotfiles
