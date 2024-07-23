#!/bin/zsh

ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/tmux ~/.config/tmux
ln -s ~/dotfiles/alacritty ~/.config/alacritty

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
