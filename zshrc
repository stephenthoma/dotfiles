unsetopt correct_all

[[ -s $HOME/.shell/aliases ]] && source $HOME/.shell/aliases
[[ -s $HOME/.shell/paths ]] && source $HOME/.shell/paths

bindkey -v
export KEYTIMEOUT=1

export EDITOR='vim'
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1 # for nvim 1.7 (ubuntu)

if type "$brew" > /dev/null; then
source $(brew --prefix)/share/antigen/antigen.zsh;
. `brew --prefix`/etc/profile.d/z.sh;
else
source ~/.antigen/antigen.zsh;
fi

antigen use oh-my-zsh

antigen bundle git
antigen bundle command-not-found
antigen bundle brew
antigen bundle vi-mode
antigen bundle tmux
antigen bundle osx
antigen bundle z
antigen bundle zsh-users/zsh-syntax-highlighting

#antigen theme stephenthoma/zsh-theme themes/bira
antigen theme refined
antigen apply

alias tmux="TERM=screen-256color-bce tmux"

alias rmtrash=trash

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source ~/.local/bin/virtualenvwrapper.sh
