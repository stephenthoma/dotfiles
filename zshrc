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

#antigen theme stephenthoma/zsh-theme themes/bira
antigen theme refined
antigen apply

alias tmux="TERM=screen-256color-bce tmux"

alias rmtrash=trash

. `brew --prefix`/etc/profile.d/z.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME'/google-cloud-sdk/path.zsh.inc' ]; then source $HOME'/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME'/google-cloud-sdk/completion.zsh.inc' ]; then source $HOME'/google-cloud-sdk/completion.zsh.inc'; fi

export HOUSTON_ENV=development
export BLENDER_EXC=/Applications/Blender/blender.app/Contents/MacOS/blender
export PYTHONPATH=/Users/thoma/code/unspun/perfectfit/fit/blender
export PGDATA=/usr/local/var/postgres
