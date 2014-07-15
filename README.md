Mac OS X ruby-dev setup script
========

## Pre-installation requirements

Mac OS X command line tools:

```
xcode-select --install
```

## Installation

Set the `DOTFILES` (default: `~/work/dotfiles`) variable in the `setup.sh` script and simply run the script on your fresh OS installation.

The script will automatically install:

* [Homebrew](http://brew.sh/)
* [oh my zsh](https://github.com/robbyrussell/oh-my-zsh)
* [tmux](http://tmux.sourceforge.net/)
* [autojump](https://github.com/joelthelion/autojump)
* [git](http://git-scm.com/) (update Mac Os X version)
* svn
* tree
* [ImageMagick](http://www.imagemagick.org/)
* [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
* [Mac Vim](https://code.google.com/p/macvim/)
* [ruby-install](https://github.com/postmodern/ruby-install)
* [chruby](https://github.com/postmodern/chruby)
* [Ruby: 1.9.3, 2.0, 2.1](https://www.ruby-lang.org)

## TODO

* Databases setup (postgres, mysql)

## Troubleshooting
If `ctags -R` finishes with error (`invalid option -R` or something like that) then you have the wrong version of CTAGS installed.
Get the newest one from the website and add `/usr/local/bin` to path before `/usr/bin`.
