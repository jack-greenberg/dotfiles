# VARIABLES
export EDITOR=$(which hx)
export PAGER=$(less -FRX)

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
source $HOME/fzf-git.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# OPTIONS
unsetopt AUTO_CD
setopt NO_BEEP
setopt RM_STAR_WAIT

bindkey -v
export KEYTIMEOUT=1
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^X" edit-command-line

export GPG_TTY=$(tty)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# EVALS
eval "$(gh completion -s zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(pyenv init -)"
source <(COMPLETE=zsh jj)
