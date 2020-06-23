#!/bin/bash

USAGE="
Welcome to Brian U's script to modify resolutions using xrandr!

Usage: ./display_resize [WIDTH] [HEIGHT]
	WIDTH is width in pixels. Default is 1920
	HEIGHT is height in pixels. Default is 1080
	Default resolution is 1080p at 60hz

If this script doesn't work, run the following commands manually, changing 1920 and 1080 to your resolution of choice:

cvt 1920 1080

xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync

xrandr --addmode Virtual1 1920x1080_60.00

xrandr --output Virtual1 --mode 1920x1080_60.00

Okay let's change the resolution then...
"

echo "$USAGE"

#Get monitor name and set default resolution
MONITOR=`xrandr | grep "connected primary" | awk '{print $1}'`
WIDTH=1920
HEIGHT=1080



if [ $# -eq 2 ]
then
	echo "Custom resolution specified! Output will be $1 and $2"
	WIDTH=$1
	HEIGHT=$2
else
	echo "Default resolution requested! Output will be $WIDTH and $HEIGHT"
fi

if [ `xrandr | grep ${WIDTH}x${HEIGHT} | wc -l` -eq 0 ]
then
	echo "Resolution doesn't exist! Creating..."

	NEW_MODE=`cvt $WIDTH $HEIGHT | awk 'NR==2' | sed 's/Modeline/xrandr --newmode/g' | sed 's/\"//g'`

	RESOLUTION_NAME=`echo $NEW_MODE | awk '{print $3}' | sed 's/\"//g'`

	$NEW_MODE

	echo $NEW_MODE

	echo $MONITOR

	echo $RESOLUTION_NAME
	
	xrandr --addmode $MONITOR $RESOLUTION_NAME
	
	xrandr --output $MONITOR --mode $RESOLUTION_NAME
else
	echo "Resolution exists in xrandr. Switching output..."

	DESIRED_MODE=`xrandr | grep ${WIDTH}x${HEIGHT} | awk 'NR==1 {print $1}' | sed 's/\"//g'`

	#If DESIRED_MODE finds the resolution, the first result will contain the monitor name and the awk will return that, so we are checking if the monitor name is present
	if [ $DESIRED_MODE == $MONITOR ]
	then
		echo "Current output matches desired output! Exiting..."
		exit 0
	fi

	echo "Desired mode differs from current mode."
	xrandr --output $MONITOR --mode $DESIRED_MODE
fi

##TODO Create xorg.conf file in /etc/X11/xorg.conf.d/10-monitor.conf

