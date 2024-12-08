# Completion and autocd
. "$HOME/.completion.zsh"
setopt autocd

# Prompt
. "$HOME/.prompt.zsh"

# Make commenting with '#' work
setopt interactivecomments

# Set vim mode for zsh
bindkey -v

# antigen plugin manager
. "$HOME/.antigen/bin/antigen.zsh"
antigen init "$HOME/.config/antigenrc"

# use Ctrl-P to accept suggestion
bindkey '^P' autosuggest-accept

# history and browsing history config
# https://zsh.sourceforge.io/Doc/Release/Options.html#History
# https://github.com/ohmyzsh/ohmyzsh/issues/1720#issuecomment-286366959
HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000000
SAVEHIST=5000000
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search

bindkey '^R' history-incremental-search-backward

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
export BAT_THEME=ansi

# Load nvm
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# neovim-in-a-bottle
. "$HOME/.config/neovim-in-a-bottle/aliases"

# set locale
# (for some reason makes pipes.sh function correctly)
# export LC_ALL='fi_FI.UTF-8'
export LC_ALL='en_US.UTF-8'

if [[ "$TERM" = "xterm-kitty" ]]; then
  alias ssh='TERM=xterm-256color ssh'
fi

# device specific configuration
if test -f "$HOME/.device.profile"; then
    . "$HOME/.device.profile"
fi
