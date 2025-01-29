#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach

export PATH=$PATH:~/.local/bin/
export PATH=$PATH:~/.local/bin/dotnet-scripts/
export EDITOR=nvim
export GOPATH=$HOME/.go

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll="ls -la"
alias cd="z"
alias cdi="zi"
alias lg=lazygit
alias mux=tmuxinator
alias ff=fastfetch
alias lzd=lazydocker
# PS1='[\u@\h \W]\$ '

eval "$(fzf --bash)"
eval "$(zoxide init bash)"
eval "$(starship init bash)"
eval "$(rbenv init -)"

[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec

set -o vi

source ~/.bash_functions

[[ ! ${BLE_VERSION-} ]] || ble-attach
