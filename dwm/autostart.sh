#!/bin/zsh

feh --bg-scale ~/Pictures/wallpapers/minimalistic/gruv-samurai-cyberpunk2077.png &
#feh --bg-scale --no-xinerama ~/Pictures/k9TDJg6.png &
compton --backend glx --paint-on-overlay --vsync opengl-swc &
setxkbmap -option caps:swapescape
setxkbmap -option altwin:ctrl_win
xinput set-button-map 11 3 2 1

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
	volSP=$(amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }')
	volume=" $volSP"
	mute=$(amixer -D pulse sget Master | grep 'Left:' | awk -F']' '{ print $2 }')
	if [ $mute = '[off' ]
	then
		volume="Vol x"
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

