dotfiles
========

## Setup script
Set the `DOTFILES` (default: `~/work/dotfiles`) variable in the `setup.sh` script and simply run the script on your fresh OS installation.

On Mac OS X the script will automatically install:

* [Homebrew](http://brew.sh/)
* [tmux](http://tmux.sourceforge.net/)
* [oh my zsh](https://github.com/robbyrussell/oh-my-zsh)
* [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
* [Mac Vim](https://code.google.com/p/macvim/)
* [ruby-install](https://github.com/postmodern/ruby-install) & [chruby](https://github.com/postmodern/chruby)

Moreover you will be prompted if you want to install:

* [Ruby: 1.9.3, 2.0, 2.1](https://www.ruby-lang.org)

Configuration files will be linked for any Linux/UNIX OS.

## CTAGS
If `ctags -R` finishes with error (`invalid option -R` or something like that) then you have the wrong version of CTAGS installed.
Get the newest one from the website and add `/usr/local/bin` to path before `/usr/bin`.
