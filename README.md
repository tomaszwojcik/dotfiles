Mac OS X setup script
========

Configuration files and system setup script (mainly for ruby developers).

## Pre-installation requirements

Download the XCode and install it's command line tools.

## Installation

Set the `DOTFILES` (default: `~/work/dotfiles`) variable in the `setup.sh` script and simply run the script on your fresh OS installation.

The script will automatically install:

* [Homebrew](http://brew.sh/)
* [oh my zsh](https://github.com/robbyrussell/oh-my-zsh)
* [tmux](http://tmux.sourceforge.net/)
* [autojump](https://github.com/joelthelion/autojump)
* [git](http://git-scm.com/) (Mac's is outdated)
* svn
* tree
* [ImageMagick](http://www.imagemagick.org/)
* [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
* [Mac Vim](https://code.google.com/p/macvim/)
* [ruby-install](https://github.com/postmodern/ruby-install)
* [chruby](https://github.com/postmodern/chruby)
* [Ruby: 1.9.3, 2.0, 2.1](https://www.ruby-lang.org)

Change `/etc/paths` so the `/usr/local/bin` will be at first place.

## Manual installation

Here are tools that I manually install:

* [1Password](https://agilebits.com/onepassword)
* [RescueTime](https://www.rescuetime.com) - time management
* [Tunnelblick](https://code.google.com/p/tunnelblick/) - VPN
* [Dash](http://kapeli.com/dash) - offline DOCS

## TODO

* Databases setup (postgres, mysql, reds)
* Split scripts: terminal/env/tools setup, ruby-setup
