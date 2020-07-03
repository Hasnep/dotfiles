# Run neofetch if in tilix
if [[ $(ps -o comm= -p $PPID) = "tilix" ]]; then
  neofetch
elif [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
  onefetch
fi

# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation
export ZSH="/home/hannes/.oh-my-zsh"

# Name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Use case-insensitive completion
CASE_SENSITIVE="false"

# Hyphen-insensitive completion (_ and - will be interchangeable)
HYPHEN_INSENSITIVE="true"

# Allow comments in interactive shells
setopt INTERACTIVE_COMMENTS

# Plugins to load
plugins=(git cargo pip ubuntu nvm auto-notify)

# Run oh my zsh
source $ZSH/oh-my-zsh.sh

# Run Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set up PATH
path+=~/.cargo/bin
path+=~/.bin
path+=/snap/bin

# Set up node
export NODE_PATH=$(which node)
