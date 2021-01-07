#!/usr/bin/env bash

dry_run=1
if [ "$1" == "-f" ]; then
  dry_run=0
fi

if [ "$dry_run" -eq 1 ]; then
  echo "=== DRY RUN MODE ==="
fi

remove_symlink() {
  dotfile=$1
  if ! [ -e "$dotfile" ]; then
    echo "$dotfile does not exist"
    return
  fi

  if [ -h "$dotfile" ]; then
    echo "Delete symlink $dotfile"
    if [ "$dry_run" -eq 0 ]; then
      rm -f "$dotfile"
    fi
  else
    echo "$dotfile is not a symlink"
  fi
}

dotfiles=(
  ".common"
  ".zshrc"
  ".zprofile"
  ".tmux.conf"
  ".tmux.conf.local"
  ".vimrc"
  ".gitconfig"
  ".gitignore_global"
  ".pip/pip.conf"
  ".ssh/config"
  ".npmrc"
  ".yarnrc"
  ".editorconfig"
  ".screenrc"
)
for dotfile in "${dotfiles[@]}"; do
  remove_symlink "$HOME/$dotfile"
done

echo "Done!"
