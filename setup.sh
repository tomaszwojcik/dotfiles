#!/usr/bin/env bash

DOTFILES="$HOME/work/dotfiles"

main() {
  if [[ $OSTYPE == *darwin* ]]; then
    echo "Noticed that you are running Mac OS X."
    mac_install_homebrew
    mac_install_oh_my_zsh
    mac_install_tmux
    mac_install_ag
    mac_install_macvim
    mac_install_ruby
  fi
  setup_zsh
  setup_tmux
  setup_vim
  setup_git
  echo "Finished, enjoy!"
}

setup_zsh() {
  echo "Linking zsh."
  slnk "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
  slnk "$DOTFILES/zsh/zprofile" "$HOME/.zprofile"
  if [[ $OSTYPE == *darwin* ]]; then
    # This is required for the vim-rspec
    echo "Moving /etc/zshenv to /etc/zshrc (for vim-rspec)"
    sudo mv /etc/zshenv /etc/zshrc
  fi
}

mac_install_homebrew() {
  echo "Installing Homebrew."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
}

mac_install_oh_my_zsh() {
  curl -L http://install.ohmyz.sh | sh
}

mac_install_tmux() {
  brew install tmux
}

mac_install_macvim() {
  brew install macvim
}

mac_install_ag() {
  brew install ag
}

mac_install_ruby() {
  echo "Installing chruby and ruby-install."
  brew install chruby
  brew install ruby-install

  declare -a rubies=("1.9.3" "2.0" "2.1")
  echo "Installing rubies."
  for ruby in ${rubies[@]}
  do
    ruby-install ruby $ruby
  done
}

setup_tmux() {
  echo "Linking tmux."
  slnk "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"
}

setup_vim() {
  echo "Linking Vim."
  slnk "$DOTFILES/vim/vimrc" "$HOME/.vimrc"
  slnk "$DOTFILES/vim/vim" "$HOME/.vim"
}

setup_git() {
  echo "Linking Git."
  slnk "$DOTFILES/git/gitignore" "$HOME/.gitignore"
  slnk "$DOTFILES/git/config" "$HOME/.gitconfig"
}

slnk() {
  ln -f -s $1 $2
}

main
