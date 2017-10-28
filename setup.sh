#!/usr/bin/env bash

if [ -z "$DOTFILES" ]; then
    echo "Set `DOTFILES2` before running this script"
    exit 1
fi

declare -a RUBY_VERSIONS=("2.4.2")
BREW_APPS="tmux tree macvim ruby-install chruby autojump git tldr watch curl ag ctags cocoapods carthage"

main() {
  if [[ $OSTYPE != *darwin* ]]; then
    echo "This script is for Mac OS X only."
    exit
  fi
  mac_install_homebrew
  mac_install_zsh
  mac_install_oh_my_zsh
  mac_install_brew_apps
  mac_install_ruby
  setup_zsh
  setup_tmux
  setup_vim
  setup_git
  echo "Finished, enjoy!"
}

mac_install_homebrew() {
  echo "Installing Homebrew."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
}

mac_install_zsh() {
  brew install zsh
}

mac_install_oh_my_zsh() {
  curl -L http://install.ohmyz.sh | sh
}

mac_install_brew_apps() {
  echo "Installing following apps via Homebrew: $BREW_APPS"
  brew install $BREW_APPS
}

mac_install_ruby() {
  rubies_str=`IFS=,; echo "${RUBY_VERSIONS[*]}"`
  echo "Installing ruby versions: $rubies_str"
  for ruby in ${RUBY_VERSIONS[@]}
  do
    ruby-install ruby $ruby
    chruby $ruby
    gem install bundler
    gem install rubocop
  done
}

setup_zsh() {
  echo "Linking zsh configuration."
  slnk "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
  # slnk "$DOTFILES/zsh/zprofile" "$HOME/.zprofile"
  # This is required for the vim-rspec
  echo "Moving /etc/zshenv to /etc/zshrc (for vim-rspec)"
  sudo mv /etc/zshenv /etc/zshrc
  echo "Updating /etc/shells."
  echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells

  echo "Updating user's shell."
  chsh -s /usr/local/bin/zsh

  echo "!!! Set user's shell in the system preferences (/usr/local/bin/zsh) and press enter..."
  read
}

setup_tmux() {
  echo "Linking tmux configuration."
  slnk "$DOTFILES/tmux" "$HOME/.tmux"
  slnk "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"
}

setup_vim() {
  echo "Linking Vim configuration."
  slnk "$DOTFILES/vim/vimrc" "$HOME/.vimrc"
  slnk "$DOTFILES/vim/vim" "$HOME/.vim"
  mkdir ~/vim_tmp
}

setup_git() {
  echo "Linking Git configuration."
  rm -f "$HOME/.gitignore"
  rm -f "$HOME/.gitconfig"
  slnk "$DOTFILES/git/gitignore" "$HOME/.gitignore"
  slnk "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"
  git config --global core.excludesfile ~/.gitignore
}

setup_atom() {
  echo "Linking Atom configuration."
  slnk "$DOTFILES/git"
}

slnk() {
  ln -f -s $1 $2
}

main
