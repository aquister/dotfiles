## Turn off laptop display, and turn on external monitors
xrandr --output eDP1 --off --output DP1 --mode 3840x2160 --rate 60 --scale 0.8x0.8 --output HDMI3 --auto --right-of DP1

## Start notification daemon
#/usr/lib/notification-daemon-1.0/notification-daemon &

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

exec i3
