#!/usr/bin/env bash

DOTFILES="$HOME/work/dotfiles"
ANSWER_NO=0
ANSWER_YES=1

main() {
  if [[ $OSTYPE == *darwin* ]]; then
    echo "Noticed that you are running Mac OS X."
    mac_install_commandline_tools
    mac_install_homebrew
    mac_install_oh_my_zsh
    mac_install_tmux
    mac_install_ag
    mac_install_macvim
    mac_install_ruby_install
    mac_install_chruby
    mac_install_rubies
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

mac_install_commandline_tools() {
  echo "Installing command line tools."
  `xcode-select --install`
  echo "Please wait until installation finishes and type 'y'..."
  ask_question "Command line tools installed? (y/n)"
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

mac_install_ruby_install() {
  echo "Installing ruby-install."
  brew install ruby-install
}


mac_install_chruby() {
  echo "Installing chruby."
  brew install chruby
}

mac_install_rubies() {
  declare -a rubies=("1.9.3" "2.0" "2.1")
  rubies_str=`IFS=,; echo "${rubies[*]}"`
  ask_question "Do you want to install the following ruby versions: $rubies_str? (Y/n)" $ANSWER_YES
  if [[ $? -eq $ANSWER_YES ]]; then
    echo "Installing ruby."
    for ruby in ${rubies[@]}
    do
      ruby-install ruby $ruby
    done
  else
    echo "Ruby not installed - install manually: ruby-install ruby <version>."
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

ask_question() {
  declare -a yes=('y' 'Y')
  declare -a no=('n' 'N')
  while : ; do
    echo $1
    read answer
    if [[ ${yes[*]} =~ $answer ]]; then
      return $ANSWER_YES
    elif [[ ${no[*]} =~ $answer ]]; then
      return $ANSWER_NO
    elif [[ ! $answer && $2 ]]; then
      return $2
    fi
  done
}

slnk() {
  ln -f -s $1 $2
}

main
