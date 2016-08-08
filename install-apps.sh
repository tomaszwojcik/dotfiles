#!/usr/bin/env bash

homebrew_apps=(
tmux
reattach-to-user-namespace
tree
curl
htop
autojump
git
macvim
swiftlint
)

homebrew_cask_apps=(
#dropbox
#google-chrome
#google-drive
#dash
)

manual_install_apps=(
1Password
Blotter
ColorSnapper2
Dash
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
