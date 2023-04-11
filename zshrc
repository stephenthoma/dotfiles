unsetopt correct_all


source $(brew --prefix)/share/antigen/antigen.zsh
antigen use oh-my-zsh

antigen bundle command-not-found
antigen bundle brew
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle buonomo/yarn-completion
antigen bundle tmux
antigen bundle osx
antigen bundle z
antigen bundle zsh-users/zsh-syntax-highlighting

#antigen theme stephenthoma/zsh-theme themes/bira
antigen theme refined
antigen apply

[[ -s $HOME/.shell/aliases ]] && source $HOME/.shell/aliases
[[ -s $HOME/.shell/paths ]] && source $HOME/.shell/paths

bindkey "ç" fzf-cd-widget
bindkey -v
export KEYTIMEOUT=1

export EDITOR='nvim'

alias tmux="TERM=screen-256color-bce tmux"

alias rmtrash=trash

. `brew --prefix`/etc/profile.d/z.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME'/google-cloud-sdk/path.zsh.inc' ]; then source $HOME'/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME'/google-cloud-sdk/completion.zsh.inc' ]; then source $HOME'/google-cloud-sdk/completion.zsh.inc'; fi

export HOUSTON_ENV=development
export BLENDER_EXC=/Applications/Blender/blender.app/Contents/MacOS/blender
export SPARROW_EXC=/Users/thoma/code/unspun/perfectfit/sparrow/sparrow
export PYTHONPATH=/Users/thoma/code/unspun/perfectfit/fit/blender/src/blender
export PGDATA=/usr/local/var/postgres
export GOOGLE_APPLICATION_CREDENTIALS=/Users/thoma/.dev-service-account.json
export GCLOUD_PROJECT=unspun-sandbox

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export HOMEBREW_AUTO_UPDATE_SECS=604800

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
