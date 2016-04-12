## Turn off laptop display, and turn on external monitor
xrandr --output eDP1 --off
xrandr --output DP1 --auto --output HDMI3 --auto --right-of DP1

## Start notification daemon
#/usr/lib/notification-daemon-1.0/notification-daemon &

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

exec i3
