#!/bin/zsh


#feh --bg-scale ~/Pictures/abstract/race-car-wallpapers_618078506.jpg &
zsh /home/jay/.config/dwm/scripts/dynamic_wallpaper.sh &
ffplay -nodisp -autoexit /home/jay/.config/dwm/ironman_repulsor_in.mp3 &
#feh --bg-scale --no-xinerama ~/Pictures/k9TDJg6.png &
#compton --backend glx --paint-on-overlay --vsync opengl-swc &
picom --config ~/.config/picom/picom.conf &
setxkbmap -option caps:swapescape
setxkbmap -option altwin:ctrl_win
xinput set-button-map $(xinput list | grep "USB Optical Mouse" | awk '{match($0, /[0-9]+/, m); print m[0]}') 3 2 1

dte(){
	dte="$(date +"%A, %B %d - %H:%M")"
	echo -e " $dte"
}

bat(){
	batStatus=`cat /sys/class/power_supply/BAT0/status`

	if [ $batStatus = 'Charging' ]
	then
		batIcon=" "
	elif [ $batStatus = 'Full' ]
	then
		batIcon=" "
	elif
	then
		case $1 in
			[0-9]|1[0-5])
				batIcon=" "
				;;
			1[6-9]|2[0-5])
				batIcon=" "
				;;
			2[6-9]|3[0-9]|4[0])
				batIcon=" "
				;;
			4[1-9]|5[0-9])
				batIcon=" "
				;;
			6[0-9]|7[0-9]|8[0-4])
				batIcon=" "
				;;
			8[5-0]|9[0-9])
				batIcon=" "
				;;
#			*)
#				batIcon=" "
#				;;
		esac
	fi
	echo -e "$batIcon$1%"
}

vol(){
	volSP=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)
	volume=" $volSP"
	mute=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)
	if [ $mute = '[off' ]
	then
		volume="Muted  "
	fi
		
	echo -e "$volume"

}

batNot(){
	batLap=$1
	if [ $batLap -eq 90 ]
	then
		zenity --info --title "Battery Charged" --text "Battery Charged current level $batLap" 
		sleep 100s
	elif [ $batLap -eq 25 ]
	then
		zenity --info --title "Battery Low" --text "Battery Low $batLap" 
		sleep 100s
	elif [ $batLap -eq 10 ]
	then
		zenity --info --title "Battery Low" --text "Battery Low $batLap" 
		sleep 100s
	elif [ $batLap -eq 5 ]
	then
		zenity --info --title "Battery CrItICaLLY Low" --text "Battery Vey Low $batLap" 
	fi
}

while true; do
	batLap=$(cat /sys/class/power_supply/BAT0/capacity)
	xsetroot -name "| $(vol) | $(bat $batLap) | $(dte) "
	sleep 10s
	batNot $batLap
done &

