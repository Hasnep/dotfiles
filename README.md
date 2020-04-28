# My .dotfiles

## Instructions

### GNU Stow

```shell
# Install GNU Stow
sudo apt install stow

# Clone this repo to ~/.dotfiles
git clone git@github.com:Hasnep/dotfiles.git ~/.dotfiles

# Run stow on all the packages
cd ~/.dotfiles
stow julia r ssh zsh
```

### dconf

To restore from files to dconf:

```shell
dconf load /com/gexperts/Tilix/ < ~/.dotfiles/tilix/tilix.dconf
dconf load /com/solus-project/ < ~/.dotfiles/budgie/budgie.dconf
```

To backup from dconf to files:

```shell
dconf dump /com/gexperts/Tilix/ > ~/.dotfiles/tilix/tilix.dconf
dconf dump /com/solus-project/ > ~/.dotfiles/budgie/budgie.dconf
```
