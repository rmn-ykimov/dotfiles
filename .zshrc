export PATH="/usr/local/bin:$PATH"
export TERM="xterm-256color"
export SHELL=/bin/zsh
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME=$HOME/.config

# Automatic update of Oh My Zsh
zstyle ':omz:update' mode auto

# Frequency of automatic updates
zstyle ':omz:update' frequency 13

# Enable command auto-correction
ENABLE_CORRECTION="true"

# Display red dots during completion waiting time
COMPLETION_WAITING_DOTS="true"

# Disable tracking untracked files in version control systems
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Format of timestamps in command history
HIST_STAMPS="mm/dd/yyyy"

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh

# Personal settings
alias ll='ls -lah'
alias h='history'

PROMPT='%F{cyan}%n@%m %F{yellow}%1~ %F{green}> %f'
