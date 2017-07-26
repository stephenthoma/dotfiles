unsetopt correct_all

[[ -s $HOME/.shell/aliases ]] && source $HOME/.shell/aliases
[[ -s $HOME/.shell/paths ]] && source $HOME/.shell/paths

bindkey -v
export KEYTIMEOUT=1

export EDITOR='vim'

source $(brew --prefix)/share/antigen/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle command-not-found
antigen bundle brew
antigen bundle vi-mode
antigen bundle tmux
antigen bundle osx
antigen bundle z
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme stephenthoma/zsh-theme themes/bira
#antigen theme pure
antigen apply

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

alias tmux="TERM=screen-256color-bce tmux"
alias tmuxinator='TERM=xterm-256color tmuxinator'
alias mux='TERM=xterm-256color mux'

alias rmtrash=trash

source ~/.bin/tmuxinator.zsh

source /usr/local/bin/virtualenvwrapper.sh

. `brew --prefix`/etc/profile.d/z.sh
