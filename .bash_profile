# Display runtime of the last command in prompt
# See: http://jakemccrary.com/blog/2015/05/03/put-the-last-commands-run-time-in-your-bash-prompt/
function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
    timer_show=$(($SECONDS - $timer))
    unset timer
}

trap 'timer_start' DEBUG

if [ "$PROMPT_COMMAND" == "" ]; then
    PROMPT_COMMAND="timer_stop"
else
    PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
fi

# Display unsuccessful exit codes
function exit_status {
    last_status=$?
    if [[ $last_status != 0 ]]; then
      echo "Exit: $last_status "
    fi
}

#Set colors
reset=$(tput setaf 189)
prompt_color=$(tput sgr0)

# Load scripts if present
optional_dependencies=(\
~/.git-completion.bash \
~/.git-prompt.sh \
~/.profile \
~/.bash_aliases \
~/.bash_util_aliases \
# https://gist.github.com/ddgenome/f13f15dd01fb88538dd6fac8c7e73f8c
~/.aws-creds.sh \
)

for file in "${optional_dependencies[@]}"
do
  if [ -f $file ]
    then
      source $file
  fi
done

# Prompt
PS1='\[$prompt_color\]$(exit_status)[last: ${timer_show}s] \D{%T} \W$(__git_ps1 " (%s)") \[$reset\]'

# Use vi mode for bash
set -o vi

# Disable flow control so I can use vim Control bindings
stty -ixon -ixoff

# Update tmux pane with name of ssh connection
ssh() {
  if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
    tmux rename-window "$(echo $* | cut -d . -f 1)"
    command ssh "$@"
    tmux set-window-option automatic-rename "on" 1>/dev/null
  else
    command ssh "$@"
  fi
}

export HISTCONTROL=ignoredups:erasedups  # prevent dups
shopt -s histappend # save history on shell exit

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# rbenv
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# redis
export PATH="/usr/local/opt/redis@3.2/bin:$PATH"

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh

