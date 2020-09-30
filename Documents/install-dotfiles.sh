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
        if ! command_exists git; then
            echo "Git must be installed"
            if command_exists apt-get; then
                echo "Installing git using apt-get..."
                sudo apt-get update
                sudo apt-get install git
            else
                echo "Please install git manually before running this installation script."
                echo "Aborting..."
                exit 1
            fi
        fi
        echo -n "Clone repository over ssh? "
        if y_n_dialog y; then
            GIT_PREFIX="git@github.com:"
        else
            GIT_PREFIX="https://github.com/"
        fi
        if command_exists apt-get; then
            echo -n "Install some useful packages (list: https://raw.githubusercontent.com/samporapeli/dotfiles/master/Documents/useful_packages_apt.txt) "
            if y_n_dialog y; then
                sudo apt-get update
                if command_exists curl; then
                    sudo apt-get install $(curl -s https://raw.githubusercontent.com/samporapeli/dotfiles/master/Documents/useful_packages_apt.txt | tr '\n' ' ')
                elif command_exists wget; then
                    sudo apt-get install $(wget -qO - https://raw.githubusercontent.com/samporapeli/dotfiles/master/Documents/useful_packages_apt.txt | tr '\n' ' ')
                else
                    echo "curl or wget required, skipping..."
                fi
            fi
        fi
        if command_exists apt-get && ! command_exists zsh; then
            echo -n "Install zsh? "
            if y_n_dialog y; then
                echo Using apt-get to install zsh...
                sudo apt-get update
                sudo apt-get -y install zsh
            fi
        fi
        echo 'Installing of oh-my-zsh (https://ohmyz.sh)'
        echo After oh-my-zsh installation you must exit the zsh shell, e. g. by typing exit and pressing enter.
        echo -n "Install oh-my-zsh? (remember to exit) "
        if y_n_dialog y; then
            sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        fi
        if [ "$INSTALL_TYPE" = "replace" ]; then
            echo ".dotfiles" >> .gitignore
            dotfiles clone --bare $GIT_PREFIX$GIT_PATH $HOME/.dotfiles
            dotfiles config --local status.showUntrackedFiles no
            echo -n "Destroy previous configuration? This cannot be undone. "
            if y_n_dialog n; then
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
