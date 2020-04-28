# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export PATH=/usr/local/cuda-10.0/bin:$HOME/dotnet:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:$LD_LIBRARY_PATH
export DOTNET_ROOT=$HOME/dotnet

# Custom aliases
alias mkcd='mkdir $1 && cd $1'
alias res='sudo systemctl restart $1'
alias stop='sudo systemctl stop $1'
alias logs='sudo journalctl -r -n 50 -u $1'
alias dlogs='sudo docker logs $1'
alias drm='sudo docker rm -f $1'
alias drmc='sudo docker rm $(sudo docker ps -a -q)'
alias drmi='sudo docker rmi $(sudo docker images -a -q)'
alias editedge='sudo nano /etc/iotedge/config.yaml'
alias editauto='sudo nano /etc/iotedge/trustedzone/autoedge-config.yaml'
alias showedge='sudo cat /etc/iotedge/config.yaml'
alias showauto='sudo cat /etc/iotedge/trustedzone/autoedge-config.yaml'
alias vsp='xclip -sel clip < ~/Documents/vstspwd.txt'
alias sd='sudo !!'
alias back='cd -'
alias edit='nano $1'
alias sedit='sudo nano $1'
alias show='cat ~/.bashrc'

# Dir 
alias home='cd'
alias documents='cd ~/documents'
alias downloads='cd ~/downloads'
alias linuxdoc='cd ~/linuxdoc'
alias music='cd ~/music'
alias pix='cd ~/pictures'
alias root='sudo -i'

# Sudo
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias purge='sudo apt-get remove --purge'
alias update='sudo apt-get update'
alias clean='sudo apt-get autoclean && sudo apt-get autoremove'
alias sources='(gksudo geany /etc/apt/sources.list &)'

# chmod and permissions commands
alias mx='chmod a+x'
alias 000='chmod 000'
alias 644='chmod 644'
alias 755='chmod 755'

# Misc
alias a='alias'
alias c='clear'
alias h='htop'
alias x='exit'
alias bg='geany ~/.bashrc'
alias pci='lspci'
alias ksf='killall swiftfox-bin'
alias del='rm --target-directory=$HOME/.Trash/'
alias font='fc-cache -v -f'

# Extracting
extract () {

 if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"

 fi
}

clear
echo -ne "Hello, $USER. today is, "; date
#export PS1="\[\e]2;\u@\H \w\a\e[30;1m\]>\[\e[0m\] "
#export PS1="\[\e]2;\u@\H \w\a\n----\nPath:\w (bash)\n----\n\u@\H $> \]"

# Applications
alias cal="cal -m -3"
alias git="nice git"
alias gsh="git stash"
alias gst="git status --short --branch"
alias gsu="git submodule update --recursive --merge"
alias gdf="git diff"
alias gdt="git difftool"
alias glo="git log"
alias gps="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gci="git commit"
alias gad="git add"
alias grm="git rm"
alias gmv="git mv"
alias gtg="git tag"
alias gbr="git branch"
alias gs="git svn"
alias gfa="git fetch --all"
alias gc='git commit -m $1'
alias gac='git commit -am $1'
alias gmerge='git merge --no-ff upstream/master'
alias greb='git pull --rebase origin master'
alias grebup='git pull --rebase upstream master'
alias gfm='git fetch --all && git merge --no-ff upstream/master'
alias gnb='git checkout -b $1'
alias gnbu='git checkout -b $1 $2'
