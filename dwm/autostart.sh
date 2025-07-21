#!/bin/zsh


zsh /home/jay/.config/dwm/scripts/dynamic_wallpaper.sh &
ffplay -nodisp -autoexit /home/jay/.config/dwm/ironman_repulsor_in.mp3 &
#compton --backend glx --paint-on-overlay --vsync opengl-swc &
picom --config ~/.config/picom/picom.conf &
dunst &
#setxkbmap -option altwin:ctrl_win
setxkbmap -option caps:swapescape
#setxkbmap -option "ctrl:swap_ralt_rctl"
#xinput set-button-map $(xinput list | grep "Telink 2.4G Mouse" | awk '{match($0, /[0-9]+/, m); print m[0]}') 3 2 1
xinput set-button-map 14 3 2 1
st -t "Welcome" -e "$SHELL" -c "neofetch; exec $SHELL" &
exec dbus-launch --sh-syntax dwmblocks &> /tmp/dwmblocks.log &

