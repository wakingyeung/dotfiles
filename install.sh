#!/usr/bin/env bash

OH_MY_ZSH="$HOME/.oh-my-zsh"
OH_MY_TMUX="$HOME/.oh-my-tmux"
OH_MY_VIM="$HOME/.vim_runtime"

#
# Create a symbolic link
#
create_symlinks() {
  # dotfile_src format such as zsh/zshrc or vim/vimrc
  dotfile_src=$1
  dotfile_dst=$2
  if [[ "$dotfile_src" != /* ]]; then
    # relative path
    dotfile_src=$PWD/$dotfile_src
  fi
  if [[ "$dotfile_dst" != /* ]]; then
    # relative path
    dotfile_dst=$HOME/$dotfile_dst
  fi
  if [ -e "$dotfile_dst" ]; then
    if [ -h "$dotfile_dst" ]; then
      ln -sf "$dotfile_src" "$dotfile_dst"
      echo "Update existed symlink $dotfile_dst"
    else
      echo "[WARN] Ignore due to $dotfile_dst exists and is not a symlink"
    fi
  else
    ln -sf "$dotfile_src" "$dotfile_dst"
    echo "Create symlink $dotfile_dst"
  fi
}

#
# Copy files
#
copy_files() {
  # dotfile_src format such as zsh/zshrc or vim/vimrc
  dotfile_src=$1
  dotfile_dst=$2
  if [[ "$dotfile_src" != /* ]]; then
    # relative path
    dotfile_src=$PWD/$dotfile_src
  fi
  if [[ "$dotfile_dst" != /* ]]; then
    # relative path
    dotfile_dst=$HOME/$dotfile_dst
  fi
  if [ -e "$dotfile_dst" ]; then
    echo "[WARN] Ignore due to $dotfile_dst exists"
  else
    cp -R "$dotfile_src" "$dotfile_dst"
    echo "Copy file from $dotfile_src to $dotfile_dst"
  fi
}

#
# brew
#
install_homebrew() {
  if [[ $(command -v brew) == "" ]]; then
    echo "Installing Hombrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Updating Homebrew..."
    brew update
  fi
}

#
# vim
#
_install_ohmyvim() {
  if [ -d "${OH_MY_VIM}" ]; then
    cd "${OH_MY_VIM}" || return
    echo "Change directory to $(pwd)"
    echo "${OH_MY_VIM} exists. Git pull to update..."
    git pull
    cd - >/dev/null 2>&1 || return
    echo "Change directory back to $(pwd)"
  else
    echo "${OH_MY_VIM} not exists. Installing..."
    git clone --depth=1 https://github.com/amix/vimrc.git "${OH_MY_VIM}"
    sh "${OH_MY_VIM}/install_awesome_vimrc.sh"
  fi
}

_install_vim_plugins() {
  if [ -d "${OH_MY_VIM}/my_plugins/vim-json" ]; then
    cd "${OH_MY_VIM}/my_plugins/vim-json" || return
    echo "Change directory to $(pwd)"
    echo "${OH_MY_VIM}/my_plugins/vim-json exists. Git pull to update..."
    git pull
    cd - >/dev/null 2>&1 || return
    echo "Change directory back to $(pwd)"
  else
    echo "${OH_MY_VIM}/my_plugins/vim-json not exists. Installing..."
    git clone --depth=1 https://github.com/elzr/vim-json.git
  fi
}

config_vim() {
  [ -d "${HOME}/.vim" ] || {
    mkdir "$HOME/.vim"
    echo "mkdir $HOME/.vim"
  }
  [ -d "${HOME}/.vim/backups" ] || {
    mkdir "$HOME/.vim/backups"
    echo "mkdir $HOME/.vim/backups"
  }
  [ -d "${HOME}/.vim/swaps" ] || {
    mkdir "$HOME/.vim/swaps"
    echo "mkdir $HOME/.vim/swaps"
  }
  [ -d "${HOME}/.vim/undo" ] || {
    mkdir "$HOME/.vim/undo"
    echo "mkdir $HOME/.vim/undo"
  }
  _install_ohmyvim
  _install_vim_plugins
  create_symlinks "vim/vimrc" "$HOME/.vim_runtime/my_configs.vim"
}

#
# git
#
config_git() {
  create_symlinks "git/gitconfig" ".gitconfig"
  create_symlinks "git/gitignore_global" ".gitignore_global"
  copy_files "git/gitconfig.local" ".gitconfig.local"
}

#
# zsh
#
_config_shell() {
  create_symlinks "common" ".common"
}

_install_ohmyzsh() {
  if [ -d "${OH_MY_ZSH}" ]; then
    cd "${OH_MY_ZSH}" || return
    echo "Change directory to $(pwd)"
    echo "${OH_MY_ZSH} exists. Git pull to update..."
    git pull
    cd - >/dev/null 2>&1 || return
    echo "Change directory back to $(pwd)"
  else
    echo "${OH_MY_ZSH} not exists. Installing ohmyzsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  autosuggestions="${OH_MY_ZSH}/custom/plugins/zsh-autosuggestions"
  if [ -d "${autosuggestions}" ]; then
    cd "${autosuggestions}" || return
    echo "Change directory to $(pwd)"
    echo "${autosuggestions} exists. Git pull to update..."
    git pull
    cd - >/dev/null 2>&1 || return
    echo "Change directory back to $(pwd)"
  else
    echo "${autosuggestions} not exists. Installing zsh-autosuggestions..."
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${autosuggestions}"
  fi

  completions="${OH_MY_ZSH}/custom/plugins/zsh-completions"
  if [ -d "${completions}" ]; then
    cd "${completions}" || return
    echo "Change directory to $(pwd)"
    echo "${completions} exists. Git pull to update..."
    git pull
    cd - >/dev/null 2>&1 || return
    echo "Change directory back to $(pwd)"
  else
    echo "${completions} not exists. Installing zsh-completions..."
    git clone --depth=1 https://github.com/zsh-users/zsh-completions "${completions}"
  fi

  syntax_highlighting="${OH_MY_ZSH}/custom/plugins/zsh-syntax-highlighting"
  if [ -d "${syntax_highlighting}" ]; then
    cd "${syntax_highlighting}" || return
    echo "Change directory to $(pwd)"
    echo "${syntax_highlighting} exists. Git pull to update..."
    git pull
    cd - >/dev/null 2>&1 || return
    echo "Change directory back to $(pwd)"
  else
    echo "${syntax_highlighting} not exists. Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${syntax_highlighting}"
  fi
}

config_zsh() {
  _install_ohmyzsh
  _config_shell
  create_symlinks "zsh/poetry" "${OH_MY_ZSH}/custom/plugins/poetry"
  create_symlinks "zsh/waking.zsh-theme" "${OH_MY_ZSH}/custom/themes/waking.zsh-theme"
  create_symlinks "zsh/zshrc" ".zshrc"
  create_symlinks "zsh/zprofile" ".zprofile"
}

#
# tmux
#
_install_ohmytmux() {
  if [ -d "${OH_MY_TMUX}" ]; then
    cd "${OH_MY_TMUX}" || return
    echo "Change directory to $(pwd)"
    echo "${OH_MY_TMUX} exists. Git pull to update..."
    git pull
    cd - >/dev/null 2>&1 || return
    echo "Change directory back to $(pwd)"
  else
    echo "${OH_MY_TMUX} not exists. Installing ohmytmux..."
    git clone --depth=1 https://github.com/gpakosz/.tmux.git "${OH_MY_TMUX}"
  fi
}

config_tmux() {
  _install_ohmytmux
  create_symlinks "${OH_MY_TMUX}/.tmux.conf" ".tmux.conf"
  create_symlinks "tmux/tmux.conf.local" ".tmux.conf.local"
}

#
# pip
#
config_pip() {
  [ -d "${HOME}/.pip" ] || {
    mkdir "$HOME/.pip"
    echo "mkdir $HOME/.pip"
  }
  create_symlinks "pip/pip.conf" ".pip/pip.conf"
}

#
# ssh
#
config_ssh() {
  [ -d "${HOME}/.ssh" ] || {
    mkdir "$HOME/.ssh"
    echo "mkdir $HOME/.ssh"
  }
  copy_files "ssh/config" ".ssh/config"
}

#
# mysql
#
config_mysql() {
  copy_files "mysql/my.cnf" ".my.cnf"
}

#
# npm
#
config_npm() {
  create_symlinks "npm/npmrc" ".npmrc"
}

#
# yarn
#
config_yarn() {
  copy_files "yarn/yarnrc" ".yarnrc"
}

#
# editorconfig
#
config_editorconfig() {
  create_symlinks "editorconfig/editorconfig" ".editorconfig"
}

#
# screen
#
config_screen() {
  create_symlinks "screen/screenrc" ".screenrc"
}

main() {
  install_homebrew
  config_zsh
  config_vim
  config_tmux
  config_git
  config_pip
  config_ssh
  config_mysql
  config_npm
  config_yarn
  config_editorconfig
  config_screen
}

main

echo "Done!"
