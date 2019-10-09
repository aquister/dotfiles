#!/bin/bash

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -r /etc/bashrc ]] && source /etc/bashrc # Source global definitions
[[ -r /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion
[[ -r "$HOME/.git-prompt.sh" ]] && source "$HOME/.git-prompt.sh"
[[ -r "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -r "$HOME/.bashrc_cisco" ]] && source "$HOME/.bashrc_cisco"
[[ -r "$HOME/.bashrc_macos" ]] && source "$HOME/.bashrc_macos"

GREEN="\[\033[40;0;32m\]"
BLUE="\[\033[40;0;34m\]"
LTGRAY="\[\033[40;1;30m\]"
LTGREEN="\[\033[40;1;32m\]"
LTBLUE="\[\033[40;1;34m\]"
LTCYAN="\[\033[40;1;36m\]"
CLEAR="\[\033[0m\]"
PS1="$LTGRAY(\$?) $GREEN[\t] $LTBLUE\u$GREEN@$LTCYAN\h$LTGREEN \w$BLUE\$(__git_ps1)$CLEAR \\$ "

export HISTCONTROL=ignoredups
export HISTFILESIZE=1000000
export HISTSIZE=1000000

export EDITOR='vim'
export BROWSER='firefox'
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export BEAKER_destroy='yes'

## Aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -lAh --literal --color=auto --group-directories-first --time-style=long-iso --context'
alias mkdir='mkdir -p -v'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias pgrep="pgrep -l"
alias df='df -hT'
alias du='du -h -c'
alias free='free -m'
alias mount='mount | column -t'
alias wget='wget --content-disposition'

alias strfind='find . -type f | xargs grep'
alias pacbackfiles='find / -regextype posix-extended -regex ".+\.pac(new|save|orig)" 2> /dev/null'
alias dockerclean='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'
alias dockerpurge='dockerclean; docker volume rm $(docker volume ls -q); docker rmi $(docker images -q)'

alias nrk-p3='mplayer http://lyd.nrk.no/nrk_radio_p3_aac_h'
alias nrk-mp3='mplayer http://lyd.nrk.no/nrk_radio_mp3_aac_h'
alias nrk-p13='mplayer http://lyd.nrk.no/nrk_radio_p13_aac_h'
alias playflash='cd /tmp && get_flash_videos --play --player vlc --quality medium --quiet'

alias ethdump='sudo tcpdump -nn -v -i enp0s25 -s 1500 -c 1 "ether[20:2] == 0x2000"'
alias pubip='dig +short myip.opendns.com @resolver1.opendns.com'

## Functions

puppyloop() {
  CONF_DIR=/etc/puppetlabs/code/environments/production/
  MANIFEST=/etc/puppetlabs/code/environments/production/manifests/site.pp 
  while true
    do inotifywait -r $CONF_DIR -e close_write && clear && sudo /opt/puppetlabs/bin/puppet apply $MANIFEST
  done
}

yamlcheck() {
  ruby -e "require 'yaml'; YAML.load_file('$1')"
}

i3name() {
  NUM=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num')
  NAME=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name')
  i3-msg "rename workspace ${NAME} to $NUM:$@"
}

dockerdebug() {
  for container in $(docker ps -q); do
    urxvt --hold -e docker exec -ti "$container" /bin/bash &
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
  if [ -f "$1" ]; then
    case $1 in
      *.tar.bz2)  tar xjf "$1"      ;;
      *.tar.gz)   tar xzf "$1"      ;;
      *.tar.xz)   tar xvfJ "$1"     ;;
      *.bz2)      bunzip2 "$1"      ;;
      *.rar)      unrar x "$1"      ;;  # package unrar
      *.gz)       gunzip "$1"       ;;
      *.tar)      tar xf "$1"       ;;
      *.tbz2)     tar xjf "$1"      ;;
      *.tgz)      tar xzf "$1"      ;;
      *.zip)      unzip "$1"        ;;  # package unzip
      *.Z)        uncompress "$1"   ;;
      *.7z)       7z x "$1"         ;;  # package p7zip
      *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

