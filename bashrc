##
## ~/.bashrc
##

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.git-prompt.sh

PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] '

export HISTCONTROL=ignoredups
export HISTFILESIZE=1000000
export HISTSIZE=1000000

export EDITOR='vim'
export BROWSER='firefox'
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export BEAKER_destroy='no'

## Aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls --tabsize=0 --literal --color=auto --show-control-chars \
  --human-readable --group-directories-first'
alias mkdir='mkdir -p -v'
alias grep='grep --color=auto'
alias pgrep="pgrep -l"
alias df='df -hT'
alias du='du -h -c'
alias free='free -m' 

alias strfind='find . -type f | xargs grep'
alias pacbackfiles='find / -regextype posix-extended -regex ".+\.pac(new|save|orig)" 2> /dev/null'
alias dockerclean='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'

alias nrk-p3='mplayer http://lyd.nrk.no/nrk_radio_p3_aac_h'
alias nrk-mp3='mplayer http://lyd.nrk.no/nrk_radio_mp3_aac_h'
alias nrk-p13='mplayer http://lyd.nrk.no/nrk_radio_p13_aac_h'
alias playflash='cd /tmp && get_flash_videos --play --player vlc --quality medium --quiet'


## Functions

dockerdebug() {
  for container in $(docker ps -q); do
    urxvt --hold -e docker exec -ti $container /bin/bash &
  done
  exit
}

## Print memory usage for applications using more than 1 MB of memory
memuse () {
  ps -e -orss=,args= | sort -b -k1,1n | \
    awk '{ if ($1 > 1000) printf("%d MB %s\n", $1/1024, $2) }'
}

## Extract a file using corrct utility based on file extension
extract () {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)  tar xjf $1      ;;
      *.tar.gz)   tar xzf $1      ;;
      *.bz2)      bunzip2 $1      ;;
      *.rar)      unrar x $1      ;;  # package unrar
      *.gz)       gunzip $1       ;;
      *.tar)      tar xf $1       ;;
      *.tbz2)     tar xjf $1      ;;
      *.tgz)      tar xzf $1      ;;
      *.zip)      unzip $1        ;;  # package unzip
      *.Z)        uncompress $1   ;;
      *.7z)       7z x $1         ;;  # package p7zip
      *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

