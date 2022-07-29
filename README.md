# dotfiles
## Requirements
- Git needs to be installed
- Currently the pluggin portion of the .vimrc throws an error on startup but works in neovim (needs to be sourced from init.vim) so neovim is required for smooth/full operation.
## Setting up
### Setup environment
Apply the following alias in the current session (will be added to .bash_aliases by the repo):
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```
Before cloning prevent the git repo from seeing itself
```bash
echo ".cfg" >> .gitignore
```
### Install the repo
Get an ssh key (if you don't already have one) and clone the repo
```bash
git clone --bare git@github.com:j-ace-svg/dotfiles.git $HOME/.cfg
```
If you can't obtain an ssh key, use https to clone the repo
```bash
git clone --bare https://github.com/j-ace-svg/dotfiles.git $HOME/.cfg
```
Get the config files from the repo into your home directory
```bash
config checkout
```
If an error is thrown regarding config files that will be overwritten, you can append the command with a -f to overwrite them or use the following command to move them to a backup folder first (then rerun the checkout)
```bash
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```
### Post-installation setup
Hide git from complaining about untracked files
```bash
config config --local status.showUntrackedFiles no
```
## Installation scripts
### Cloning but not editing (non developer)
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo ".cfg" >> .gitignore
git clone --bare https://github.com/j-ace-svg/dotfiles.git $HOME/.cfg
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
config checkout
config config --local status.showUntrackedFiles no
```
### Development (requires preset ssh key)
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo ".cfg" >> .gitignore
git clone --bare git@github.com:j-ace-svg/dotfiles.git $HOME/.cfg
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
config checkout
config config --local status.showUntrackedFiles no
```
