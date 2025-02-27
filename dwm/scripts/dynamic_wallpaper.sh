#!/bin/zsh

#From https://www.youtube.com/watch?v=NjN9-p1r-d0
#
#kill the script if it's already running useful if you're constantly restarting x
for pid in $(pidof -x dynamic_wallpaper.sh); do
     if [ $pid != $$ ]; then
         kill -9 $pid
         exit 1
     fi
done

#Enter Pictures directory

cd "$HOME/Pictures"
folders=($(ls))
rand=($((1 + $RANDOM % 6)))

#Wallpaper directory
cd "$HOME/Pictures/$folders[$rand]/"

#Get the names of all the pics in the directory
wallpapers=($(ls))

#get the absolute paths of the pics
for pic in "${wallpapers[@]}"
 do
 :
 wallpath+=($(readlink -f $pic))
done

while true; do

 for p in "${wallpath[@]}"
  do
  :
  feh --bg-fill $p 
  sleep 120s
 done

done
