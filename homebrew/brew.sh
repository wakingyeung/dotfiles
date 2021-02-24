#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install font tools.
brew tap homebrew/cask-fonts
brew install --cask homebrew/cask-fonts/font-fira-code
brew install --cask homebrew/cask-fonts/font-source-code-pro
brew install --cask homebrew/cask-fonts/font-hack
brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono

# Install services manager
brew tap homebrew/services

# Install MongoDB
brew tap mongodb/brew
brew install mongodb/brew/mongodb-community

# Install useful binaries.
brew install ack
brew install aria2
brew install arping
brew install axel
brew install bandit
brew install bat
brew install black
brew install coreutils
brew install curl
brew install dos2unix
brew install duf
brew install flake8
brew install fd
brew install findutils
brew install fortune
brew install fping
brew install fzf
brew install gawk
brew install geoip
brew install gh
brew install gist
brew install git
brew install git-lfs
brew install ghostscript
brew install gmp
brew install gnu-getopt
brew install gnupg
brew install gnu-sed
brew install go
brew install grep
brew install highlight
brew install htop
brew install httpie
brew install imagemagick
brew install ipcalc
brew install iproute2mac
brew install ipython
brew install isort
brew install jq
brew install kubectl
brew install lazydocker
brew install lazygit
brew install lnav
brew install mercurial
brew install mitmproxy
brew install moreutils
brew install mosh
brew install mtr
brew install mutt
brew install mycli
brew install mypy
brew install mysql
brew install nginx
brew install nmap
brew install node
brew install openssh
brew install openssl@1.1
brew install pdsh
brew install pgcli
brew install poetry
brew install polipo
brew install postgresql
brew install pssh
brew install pstree
brew install python
brew install ranger
brew install reattach-to-user-namespace
brew install redis
brew install ripgrep
brew install screen
# brew install shellcheck
brew install shfmt
brew install smartmontools
brew install sqlite
brew install the_silver_searcher
brew install tig
brew install tldr
brew install tmux
brew install tmuxinator
brew install tree
brew install vim
brew install watch
brew install wget
brew install yarn
brew install you-get
brew install youtube-dl
brew install zsh-autosuggestions
brew install zsh-completions
brew install zsh-syntax-highlighting

# Install cask.
brew install --cask adoptopenjdk
brew install --cask alfred
brew install --cask anki
brew install --cask appcleaner
# brew install --cask brave-browser
# brew install --cask blender
brew install --cask charles
brew install --cask cheatsheet
# brew install --cask clashx
brew install --cask dash
brew install --cask deepl
# brew install --cask docker
brew install --cask enpass
brew install --cask eudic
brew install --cask firefox
brew install --cask fliqlo
brew install --cask fsnotes
brew install --cask gitup
brew install --cask google-chrome
brew install --cask grandperspective
brew install --cask hiddenbar
brew install --cask homebrew/cask-drivers/logitech-options
brew install --cask iina
brew install --cask imageoptim
brew install --cask imazing
brew install --cask iterm2
brew install --cask itsycal
brew install --cask kap
# brew install --cask karabiner-elements
brew install --cask keka
brew install --cask kindle
# brew install --cask libreoffice
# brew install --cask libreoffice-language-pack
# brew install --cask liya
brew install --cask maccy
brew install --cask macdown
# brew install --cask menumeters
brew install --cask mysqlworkbench
brew install --cask notion
brew install --cask obs
brew install --cask obsidian
brew install --cask paw
brew install --cask postman
brew install --cask raspberry-pi-imager
brew install --cask royal-tsx
# brew install --cask shadowsocksx-ng-r
brew install --cask skim
brew install --cask sourcetree
brew install --cask spotify
brew install --cask sublime-text
brew install --cask tableplus
brew install --cask teamviewer
brew install --cask telegram
brew install --cask telegram-desktop
brew install --cask tencent-meeting
brew install --cask textmate
brew install --cask transmission
brew install --cask typora
# brew install --cask vagrant
# brew install --cask virtualbox
# brew install --cask virtualbox-extension-pack
brew install --cask visual-studio-code
brew install --cask homebrew/cask-versions/visual-studio-code-insiders
# brew install --cask vmware-fusion
brew install --cask wechat
brew install --cask wechatwork
brew install --cask wireshark

# Install cask for quick look.
brew install --cask qlcolorcode
brew install --cask qlimagesize
brew install --cask qlmarkdown
brew install --cask qlprettypatch
brew install --cask qlstephen
brew install --cask qlvideo
brew install --cask provisionql
brew install --cask quicklook-csv
brew install --cask quicklook-json

# Remove outdated versions from the cellar.
brew cleanup
