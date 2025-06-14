# cd from anywhere
function cf() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]; then
    if [[ -d $file ]]; then
      cd -- $file
    else
      cd -- ${file:h}
    fi
  fi
}

# cd to selected directory, including hidden ones. will search on current directory
function fda() {
  local dir
  dir=$(find ${1:-.} -type d 2>/dev/null | fzf +m) && cd "$dir"
}

# Find files
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
function fo() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e --preview="bat --color=always {}")")
  key=$(head -1 <<<"$out")
  file=$(head -2 <<<"$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

function nvims() {
  items=("lazynvim" "my" "bare")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "lazynvim" ]]; then
    config=""
  fi
  NVIM_APPNAME=nvim/$config nvim "$@"
}

function checkout-empty() {
  git checkout $(git commit-tree $(git hash-object -t tree /dev/null) </dev/null)
}

function fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [[ -n "$pid" ]]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
}

function fkillp() {
  local pid
  pid=$(lsof -i -P -n | sed 1d | fzf --multi --exact --header="Select processes to kill (use TAB to select multiple)" | awk '{print $2}')

  if [[ -n "$pid" ]]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
}

writecmd() { perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }'; }

fhe() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | writecmd
}

# lazygit with yadm
function ylg() {
  cd ~
  yadm enter lazygit
  cd -
}

function ynvim() {
  file=$(yadm list -a | fzf) && nvim $HOME/$file
}

tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1")
    return
  fi

  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) && tmux $change -t "$session" || echo "No sessions found."
}

tkill() {
  local sessions
  sessions=$(tmux ls | fzf --exit-0 --multi) || return $?
  while IFS= read -r session; do
    if [[ $session =~ ^([^:]+): ]]; then
      echo "Killing ${BASH_REMATCH[1]}"
      tmux kill-session -t "${BASH_REMATCH[1]}"
    fi
  done <<<"$sessions"

}

sws() {
  local current_directory_name=$(basename "$PWD")
  tmuxinator start default -n "$current_directory_name" .
}
