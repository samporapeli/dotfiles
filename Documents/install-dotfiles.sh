#!/bin/bash

function install_dotfiles() {
    # Get the necessary functions used
    if command -v curl &> /dev/null; then
        source <(curl -s https://raw.githubusercontent.com/samporapeli/dotfiles/master/.shell_scripts)
    elif command -v wget /dev/null; then
        source <(wget -qO - https://raw.githubusercontent.com/samporapeli/dotfiles/master/.shell_scripts)
    else
        echo "You must have curl or wget installed to complete installation."
        exit 1
    fi

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
        if command -v apt-get &> /dev/null && ! command -v zsh &> /dev/null; then
            echo -n "Install zsh? [Y/n] "
            read INSTALL_ZSH
            if [ "$INSTALL_ZSH" = "" ] || [ "$INSTALL_ZSH" = "y" ]; then
                echo Using apt-get to install zsh...
                sudo apt-get -y install zsh
            fi
        fi
        echo 'Installing of oh-my-zsh (https://ohmyz.sh)'
        echo After oh-my-zsh installation you must exit the zsh shell, e. g. by typing exit and pressing enter.
        echo -n "Install? (remember to exit) [Y/n] "
        read OH_MY_ZSH
        if [ "$OH_MY_ZSH" = "" ] || [ "$OH_MY_ZSH" = "y" ]; then
            sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        fi
        if [ "$INSTALL_TYPE" = "replace" ]; then
            echo ".dotfiles" >> .gitignore
            dotfiles clone --bare $GIT_PREFIX$GIT_PATH $HOME/.dotfiles
            dotfiles config --local status.showUntrackedFiles no
            echo -n "Destroy previous configuration? This cannot be undone. [y/N] "
            read DESTROY_CONFIRMATION
            if [ "$DESTROY_CONFIRMATION" = "y" ]; then
                echo Copying files...
                dotfiles checkout -f master
                echo Downloading git submodules...
                dotfiles submodule init
                bash -c "$HOME/bin/vim-plugin update" 
            else
                echo Aborting...
                exit
            fi
        elif [ "$INSTALL_TYPE" = "clone" ]; then
            git clone $GIT_PREFIX$GIT_PATH
        fi
    elif [ "$INSTALL_TYPE" = "exit" ]; then
        exit
    else
        echo Invalid input, exiting
        exit
    fi
}
install_dotfiles
