# My .dotfiles

This repo is designed to be cloned as a bare repo in my home directory to quickly restore lots of my configuration files.
I followed [this tutorial](https://www.atlassian.com/git/tutorials/dotfiles) to set it up.

## Instructions

```shell
# Install git
sudo apt install git

# Create an alias
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# Clone the repo
git clone --bare git@github.com:Hasnep/dotfiles.git $HOME/.dotfiles

# Check out the repo
dotfiles checkout

# Don't show untracked files
dotfiles config --local status.showUntrackedFiles no
```

### dconf

To restore from files to dconf:

```shell
dconf load /com/solus-project/ < ~/dconf/budgie.conf
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ~/dconf/keybindings.conf
```

To backup from dconf to files:

```shell
mkdir -p ~/dconf
dconf dump /com/solus-project/ > ~/dconf/budgie.conf
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > ~/dconf/keybindings.conf
```
