##
## ~/.bashrc
##

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PS1='[\u@\h:\w]\n\$ '
export HISTCONTROL=ignoredups   # Don't put duplicate lines in the history.
export EDITOR='vim'
export BROWSER='firefox'

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
alias playflash='cd /tmp && get_flash_videos --play --player vlc --quality medium --quiet'

alias nrk-p3='mplayer http://lyd.nrk.no/nrk_radio_p3_aac_h'
alias nrk-mp3='mplayer http://lyd.nrk.no/nrk_radio_mp3_aac_h'
alias nrk-p13='mplayer http://lyd.nrk.no/nrk_radio_p13_aac_h'


## Functions

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

## remindme - a simple reminder
## e.g.: remindme 10m "omg, the pizza"
remindme() {
  sleep $1 && notify-send -t 0 "$2" &
}

## Set USB Mouse Acceleration
## e.g.: setusbmouseaccel 5
setusbmouseaccel() {
  ACCEL=4
  if [ $1 ]; then
    ACCEL=$1
  fi
  xinput --set-prop "USB Mouse" "Device Accel Constant Deceleration" $ACCEL
  xinput --set-prop "Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)" \
    "Device Accel Constant Deceleration" $ACCEL
}

