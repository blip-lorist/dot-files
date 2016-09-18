# Set colors
export TERM='xterm-256color'
PROMPT_COLOR='\e[38;5;97m'
ALERT_COLOR='\e[1;37;41m'
NO_COLOR='\e[0m'
COMMAND_COLOR='\e[0;37m'

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

# Fancy exit status
exit_status()
{
    last_status=$?
    if [[ $last_status != 0 ]]; then
        printf "$ALERT_COLOR[Exit: $last_status]$NO_COLOR "
    fi
}

PS1='$(exit_status)'"${PROMPT_COLOR}[last: ${timer_show}s] \D{%T}  \W ${COMMAND_COLOR}"

# Use vi mode for bash
set -o vi

# Disable flow control so I can use vim Control bindings
stty -ixon -ixoff

# Git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

alias bundlewp='bundle --without production'
alias ll='ls -lah'
alias sandbox="cd ~/sandbox"
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias go='git checkout'
alias gk='gitk --all&'
alias gx='gitx --all'

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
