# VARIABLES
export GOPATH=$HOME/go
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-256color
export EDITOR=vim
export ZSH_THEME=spaceship
export ZEPHYR_BASE=~/zephyr/zephyr
export ALACRITTYRC=~/.config/alacritty/alacritty.yml
export VIMRC=~/.config/nvim/init.lua

fpath[1,0]=~/.zsh/completion/
fpath+=~/.zfunc

# PATH
prepend_path() {
  if [ -d "$1" ]; then
    export PATH="$1:$PATH"
  fi
}

prepend_path /home/jgreenberg/.pyenv/bin
prepend_path /home/jgreenberg/bin
prepend_path $GOPATH/bin
prepend_path /home/jgreenberg/.npm-global/bin
prepend_path /usr/local/go/bin
prepend_path /home/jgreenberg/.rbenv/bin
prepend_path /home/jgreenberg/.rbenv/plugins/ruby-build/bin

# PLUGINS
plugins=(
  git
  docker
  docker-compose
)

# Use for dotfiles that aren't managed by dot
try_source() {
    [ ! -s $1 ] || source $1
}

# SOURCES
try_source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.spaceship
try_source $HOME/.travis/travis.sh
try_source $HOME/astris_dev/unpack_all.sh

# OPTIONS
unsetopt AUTO_CD
setopt NO_BEEP
setopt RM_STAR_WAIT

# EVALS
eval "$(gh completion -s zsh)"
eval "$(zoxide init zsh)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init -)"
eval "$(thefuck --alias)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/bitcomplete bit

bindkey -v
export KEYTIMEOUT=1
