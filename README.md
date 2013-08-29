dotfiles
========

#### Git setup
Set global gitignore file: `git config --global core.excludesfile '<path_to_dotfiles>/git/gitignore'`

#### Vim setup
Setup `.vim` dir and `.vimrc` files in the home dir:<br>
`ln -s <path_to_dotfiles>/vim/vim .vim`<br>
`ln -s <path_to_dotfiles>/vim/vimrc .vimrc`<br>

##### vim-rspec
If using zsh on OS X it may be necessary to run move `/etc/zshenv` to `/etc/zshrc`.
