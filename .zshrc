export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"

# Do not ask to update
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Custom binaries and scripts
export PATH=$PATH:~/bin:~/.local/bin
source ~/.shell_scripts

# Set editor
if command_exists nvim; then
    export VISUAL=nvim
elif command_exists vim; then
    export VISUAL=vim
elif command_exists nano; then
    export VISUAL=nano
fi
if [ -z ${VISUAL+x} ]; then
    echo '$VISUAL is not set'
else
    export EDITOR=$VISUAL
fi
# Set vim mode for zsh
bindkey -v
# Include aliases dotfile
source ~/.aliases

# Alias code to codium, if code is not defined
if ! command_exists code; then
    alias code=codium
fi

# Alias bat to batcat, if bat is not already defined
if ! command_exists bat; then
    alias bat=batcat
fi
# bat theme
export BAT_THEME=ansi-dark

# Load nvm
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# device specific configuration
if test -f $HOME/.device.profile; then
    source $HOME/.device.profile
fi
