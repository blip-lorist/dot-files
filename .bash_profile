#Set colors
PROMPT_COLOR="$(tput setaf 4)"
ALERT_COLOR="$(tput setaf 1)"
COMMAND_COLOR="$(tput setaf 7)"

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
        echo "$ALERT_COLOR[Exit: $last_status]$PROMPT_COLOR"
    fi
}

PS1='\[${PROMPT_COLOR}\]\[$(exit_status)\][last: ${timer_show}s] \D{%T} \W \[${COMMAND_COLOR}\]'

# Use vi mode for bash
set -o vi

# Disable flow control so I can use vim Control bindings
stty -ixon -ixoff

# Git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi


source ~/.profile
source ~/.bash_aliases

# rbenv
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
