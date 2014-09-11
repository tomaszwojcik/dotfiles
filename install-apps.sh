#!/usr/bin/env bash

homebrew_apps=(
tmux
tree
curl
wget
autojump
the_silver_searcher
pgrep
git
svn
libtiff
imagemagick
ghostscript
macvim
ruby-install
chruby
postgresql
mysql
redis
)

homebrew_cask_apps=(
vagrant
tunnelblick
dropbox
google-chrome
google-drive
skype
libreoffice
rescuetime
dash
)

manual_install_apps=(
1Password
Blotter
)

install_apps() {
  for app in ${!2}
  do
    $1 $app
  done
}

install_manually_info() {
  echo 'Install manually:'
  for app in ${!1}
  do
    echo $app
  done
}

trap 'exit 0' SIGTERM # Handle that

install_apps 'brew install' homebrew_apps[@]
install_apps 'brew cask install' homebrew_cask_apps[@]
install_manually_info manual_install_apps[@]
