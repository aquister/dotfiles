## Turn off laptop display, and turn on external monitors
#xrandr --output eDP1 --off --output DP1 --mode 3840x2160 --rate 60 --scale 0.8x0.8 --output HDMI3 --auto --right-of DP1

## Scale DX80 monitor
xrandr --output DVI-D-0 --scale 1.3x1.3 --auto

## Start notification daemon
#/usr/lib/notification-daemon-1.0/notification-daemon &

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

exec dbus-launch --autolaunch=$(cat /var/lib/dbus/machine-id) i3

#exec i3
