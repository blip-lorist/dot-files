#Ctags
alias genctags="ctags -R -f ./.git/tags"

# Testing shortcuts
alias unittest="python3 -m unittest -v"
alias minitest="bundle exec rake test"

# CPU core count: does not work on MacOS
alias cpus='cat /proc/cpuinfo | awk "/^processor/{print $3}" | wc -l'

# Git
alias gpull='git pull; genctags'
alias ll='ls -lah'
alias gs='git status'
alias ga='git add'
alias gb='git branch --sort=committerdate'
alias gbr='git branch --remotes'
alias gc='git commit'
alias gpush='if grep -r --exclude-dir={.git,tmp,log,coverage,public} -Hn binding.pry .; then echo Please remove breakpoints in the above files; else git push; fi'
alias gd='git diff'
alias go='git checkout'
alias gk='gitk --all&'
alias gx='gitx --all'

# Copy file to clipboard
# Useage: copy <filename>
function copy() {
  # Arg validation
  if [ -z "$1" ]
    then
      echo "No argument supplied"
      return 1
  fi

  if [ ! -f $1 ]; then
    echo "File not found!"
    return 1
  fi

  # copy file
  cat "$1" |  xclip -selection clipboard
}

# graphviz: generate and open dot file as png
function graphviz() {
  # Arg validation
  if [ -z "$1" ]
    then
      echo "No argument supplied"
      return 1
  fi

  if [ ! -f $1 ]; then
    echo "File $1 not found!"
    return 1
  fi

  png_filename="$(echo $1 | sed 's/\.dot/\.png/g')"

  # Generate a .png file from the .dot file
  dot -Tpng "$1" -o "$png_filename"

  # Open in image viewer
  eog "$png_filename" &
}

# IP checks
alias localip="ifconfig | grep 'inet ' | grep -Fv 127.0.0.1 | awk '{print \$2}'"
alias externalip="curl ipecho.net/plain ; echo"

#Create gif from mov
# mov2gif <input.mov> <output.gif> <max_width>
function mov2gif() {
  ffmpeg -i $1 -vf scale=$3:-1 -r 5 -f gif - | gifsicle -O3 -o $2
}

# Shoutout to @rushton
# log-book function, creates a template for working through problems.
# Requires a folder called logbook in the home directory
# Usage: `lb <problem summary>`
# or just `lb` to open the latest logbook
function lb() {
    now=$(date '+%Y-%m-%d')
    # if no parameters provided and logbook entries exist, open the logbook
    # with the maximum date.
    if [[ $# -eq 0 && $(ls ~/logbook | grep "^[0-9].*md$" | wc -l) -gt 0 ]]
    then
        vim ~/logbook/$(ls ~/logbook | grep "^[0-9].*md$" | sort | tail -n1)
        return 0
    elif [[ $# -eq 1 ]]
    then
        echo "" >> ~/logbook/$now.md
        echo "$1" >> ~/logbook/$now.md
        echo "===============================================" >> ~/logbook/$now.md
        echo "Started: $(date '+%Y-%m-%d %H:%M:%S')" >> ~/logbook/$now.md
        echo "### 1. Consider the problem you’re attempting to solve" >> ~/logbook/$now.md
        echo "### 2. Describe your method for solving it" >> ~/logbook/$now.md
        echo "### 3. Describe the process of carrying out the method" >> ~/logbook/$now.md
        echo "### 4. Record what happened" >> ~/logbook/$now.md
        echo "### 5. How could it be improved?" >> ~/logbook/$now.md
        echo "Completed: <use: date '+%Y-%m-%d %H:%M:%S'>" >> ~/logbook/$now.md
    elif [[ $# -gt 1 ]]
    then
        echo "Error: too many parameters"
        echo "Usage: lb [<problem summary>]"
        return 1
    fi

    vim ~/logbook/$now.md
}

# Dynamically detect two monitor names and mirror
# Used on Ubuntu 18.06
# Useage:  mirror
function mirror() {
  # detect monitors
  monitors=$(xrandr | grep " connected"  | grep "mm x" | awk -F " " '{print $1}')
  first_monitor=$(echo $monitors | awk -F " " '{print $1}')
  second_monitor=$(echo $monitors | awk -F " " '{print $2}')
  xrandr --output $first_monitor --same-as $second_monitor
}
