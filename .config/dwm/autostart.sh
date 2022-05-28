#!/bin/bash

setxkbmap -option caps:swapescape &
feh --bg-scale ~/Pictures/k9TDJg6.png &
compton -f &

dte(){
	dte="$(date +"%A, %B %d - %H:%M")"
	echo -e " $dte"
}

bat(){
	batLap=`cat /sys/class/power_supply/BAT0/capacity`
	batStatus=`cat /sys/class/power_supply/BAT0/status`

	if [ $batStatus = 'Charging' ]
	then
		batIcon=" "
	else
		case $batLap in
			[0-15])
				batIcon=" "
				;;
			[16-25])
				batIcon=" "
				;;
			[26-40])
				batIcon=" "
				;;
			[41-60])
				batIcon=" "
				;;
			[61-84])
				batIcon=" "
				;;
			[85-100])
				batIcon=" "
				;;
			*)
				batIcon=" "
				;;
		esac
	fi
	echo -e "$batIcon$batLap%"
}

vol(){
	volSP=$(amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }')
	echo -e "$volSP"

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
	elif [ $batLap -eq 20 ]
	then
		zenity --info --title "Battery Low" --text "Battery Low $batLap" 
		sleep 100s
	elif [ $batLap -eq 10 ]
	then
		zenity --info --title "Battery Low" --text "Battery Vey Low $batLap" 
	fi
}

while true; do
	xsetroot -name " $(vol) | $(bat) | $(dte) "
	sleep 10s
	batLap=`cat /sys/class/power_supply/BAT0/capacity`
	batNot $batLap
done &

