#!/usr/bin/env bash

# dotfiles directory
dir=~/dotfiles

filelist=(
  # xinitrc
  # Xresources
  bash_profile
  bashrc
  bash_logout
  git-prompt.sh
  gitconfig
  vimrc
  # rpmmacros
  tmux.conf
  # livestreamerrc
  rtorrent.rc
  # config/i3/config
  # weechat
)

for file in ${filelist[@]}; do
  echo "Creating symlink to $file in home directory."
  ln -sf $dir/$file ~/.$file
done

