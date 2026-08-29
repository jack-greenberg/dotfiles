# VARIABLES
export EDITOR=nvim

# PATH
prepend_path() {
  if [ -d "$1" ]; then
    export PATH="$1:$PATH"
  fi
}

prepend_path $HOME/.local/bin
prepend_path $HOME/.cargo/bin
prepend_path $HOME/bin

# Use for dotfiles that aren't managed by dot
try_source() {
    [ ! -s $1 ] || source $1
}

# SOURCES
source $HOME/.aliases
source $HOME/.oh-my-zsh/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh && source <(fzf --zsh)

# OPTIONS
unsetopt AUTO_CD
setopt NO_BEEP
setopt RM_STAR_WAIT

bindkey -v
export KEYTIMEOUT=1

export GPG_TTY=$(tty)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

# EVALS
eval "$(gh completion -s zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(pyenv init -)"
