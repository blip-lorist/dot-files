source ~/.profile

PS1='\[\e[0;32m\]\u \W🐉\[\e[0;37m\] '

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

alias forks='cd ~/adacode/projects/project-forks'
alias caps='cd ~/adacode/projects/project-forks/C3Projects--Capstone'
alias bundlewp='bundle --without production'
alias ll='ls -lah'
alias sandbox="cd ~/adacode/sandbox"
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias go='git checkout'
alias gk='gitk --all&'
alias gx='gitx --all'
alias jekylls='bundle exec jekyll serve'

# added by Anaconda 2.3.0 installer
export PATH="/Users/lorainekv/anaconda/bin:$PATH"
# for treat gem
export "JAVA_HOME=\$(/usr/libexec/java_home)"

source ~//anaconda/bin/virtualenvwrapper.sh
# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups

# append history entries..
shopt -s histappend

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
