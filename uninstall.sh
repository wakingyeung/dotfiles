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
  ".vim_runtime/my_configs.vim"
  ".gitconfig"
  ".gitignore_global"
  ".pip/pip.conf"
  ".my.cnf"
  ".npmrc"
  ".editorconfig"
  ".screenrc"
)
for dotfile in "${dotfiles[@]}"; do
  remove_symlink "$HOME/$dotfile"
done

remove_file() {
  dotfile=$1
  if ! [ -e "$dotfile" ]; then
    echo "$dotfile does not exist"
    return
  fi

  if [ -d "$dotfile" ]; then
    echo "Delete directory $dotfile"
  else
    echo "Delete file $dotfile"
  fi

  if [ "$dry_run" -eq 0 ]; then
    rm -rf "$dotfile"
  fi
}

dotfiles=(
  ".gitconfig.local"
  ".oh-my-tmux"
  ".oh-my-zsh"
  ".ssh/config"
  ".vim"
  ".vim_runtime"
  ".yarnrc"
)
for dotfile in "${dotfiles[@]}"; do
  remove_file "$HOME/$dotfile"
done

echo "Done!"
