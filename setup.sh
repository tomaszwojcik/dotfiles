#!/usr/bin/env bash

DOTFILES="$HOME/work/dotfiles"

main() {
  echo "Setting up dotfiles:"
  setup_zsh
  setup_tmux
  setup_vim
  setup_git
  setup_ruby
}

setup_zsh() {
  echo "Linking zsh."
  slnk "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
  slnk "$DOTFILES/zsh/zprofile" "$HOME/.zprofile"
  if [[ $OSTYPE == *darwin* ]]; then
    # This is required for the vim-rspec
    echo "Mac OS X detected, moving /etc/zshenv to /etc/zshrc"
    sudo mv /etc/zshenv /etc/zshrc
  fi
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

setup_ruby() {
  if [[ $OSTYPE == *darwin* ]]; then
    echo "Do you want to install chruby and ruby-install (requires Homebrew)? (y/N)"
    read answer
    if [[ ($answer == "y") || ($answer == "Y") ]]; then
      echo "Installing chruby and ruby-install."
      brew install chruby
      brew install ruby-install


      echo "Do you want to install rubies: 1.9.3, 2.0, 2.1? (y/N)"
      read answer
      if [[ ($answer == "y") || ($answer == "Y") ]]; then
        ruby-install ruby 1.9.3
        ruby-install ruby 2.0
        ruby-install ruby 2.1
      else
        echo "Rubies not installed."
      fi
    else
      echo "chruby and ruby-install not installed."
    fi
  fi
}

slnk() {
  ln -f -s $1 $2
}

main
