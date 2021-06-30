# Prompt
. "$HOME/.prompt.zsh"

# antigen plugin manager
. "$HOME/.antigen/bin/antigen.zsh"
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# use Ctrl-P to accept suggestion
bindkey '^P' autosuggest-accept

# history and zsh-history-substring-search config
# https://zsh.sourceforge.io/Doc/Release/Options.html
HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Custom binaries and scripts
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
. "$HOME/.shell_scripts"

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
. "$HOME/.aliases"

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
if test -f "$HOME/.device.profile"; then
    . "$HOME/.device.profile"
fi
