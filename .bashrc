#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach

shopt -s histappend

export PATH=$PATH:~/.local/bin/
export PATH=$PATH:~/.dotnet/tools
export EDITOR="nvim"
export GOPATH=$HOME/.go
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export NVIM_APPNAME=nvim/lazynvim

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll="ls -la"
alias cd="z"
alias cdi="zi"
alias lg=lazygit
alias mux=tmuxinator
alias ff=fastfetch
alias lzd=lazydocker

alias nvim-bare="NVIM_APPNAME=nvim/bare nvim"
alias nvim-lazy="NVIM_APPNAME=nvim/lazynvim nvim"
alias nvim-my="NVIM_APPNAME=nvim/my nvim"

eval "$(fzf --bash)"
eval "$(zoxide init bash)"
eval "$(starship init bash)"
eval "$(rbenv init -)"

[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"

source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
# source /usr/share/nvm/install-nvm-exec

set -o vi

source ~/.bash_functions
source /usr/share/git/completion/git-completion.bash

[[ ! ${BLE_VERSION-} ]] || ble-attach
. "$HOME/.cargo/env"
export CAPLINQ_CONTAINER_PATH="/home/dan/Documents/work"
export PATH=/home/dan/Documents/work/bin:$PATH
