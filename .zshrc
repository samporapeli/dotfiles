# Prompt
. $HOME/.prompt.zsh

# antigen plugin manager
. $HOME/.antigen/bin/antigen.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

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
