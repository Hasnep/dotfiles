# Run neofetch on startup
neofetch

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
plugins=(git cargo pip ubuntu nvm)

# Run oh my zsh
source $ZSH/oh-my-zsh.sh

# Run Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Run undistract-me
source /etc/profile.d/undistract-me.sh

# Set up PATH
export PATH=~/bin:$PATH
