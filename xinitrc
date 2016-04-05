## Set Norwegian keyboard layout
setxkbmap -layout no

## Set keyboard repeat delay and rate
xset r rate 180 30

## Set mouse accel
xinput --set-prop "Logitech M505/B605" "Device Accel Constant Deceleration" 4

## Turn off laptop display, and turn on external monitor
xrandr --output eDP1 --off
xrandr --output DP1 --auto --output HDMI3 --auto --right-of DP1

## Start notification daemon
#/usr/lib/notification-daemon-1.0/notification-daemon &

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

exec i3
