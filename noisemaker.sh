#!/bin/bash

# Licensed under the GNU GPL v3.0.
# (epilepsy warning)
# REQUIRES and DEPENDS UPON zenity, espeak, paplay, bash, and a working 'fortune' command.
# The reminder currently triggers at a set time by default and there is no simple way to adjust this outside of editing the bash scripts manually in multiple places, at the moment.

# License information
# This product is licensed under the GNU GPL v3.0.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License (v3.0) for more details.
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see https://www.gnu.org/licenses/gpl-3.0.en.html.
# THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY
# APPLICABLE LAW. EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS
# AND/OR OTHER PARTIES PROVIDE THE PROGRAM “AS IS” WITHOUT WARRANTY OF ANY KIND,
# EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE
# RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU. SHOULD THE
# PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
# REPAIR OR CORRECTION.

# Final check, for accuracy.
TIMEHOURTIMEKEEPING="$( date +'%H')"
TIMEMINUTETIMEKEEPING="$( date +'%M')"

# Debug, comment out in final, comment out above if using for testing.
#TIMEHOURTIMEKEEPING="$(echo 06)"
#TIMEMINUTETIMEKEEPING="$(echo 59)"

if ! [ "$TIMEHOURTIMEKEEPING" == "06" ]; then exit; fi
if ! [ "$TIMEMINUTETIMEKEEPING" == "59" ]; then exit; fi

# Try to account for delays, to start making noise at exactly 07:00:00 AM
sleep 45s

# HACK: actually, let's wake up at 8 instead.
sleep 3600s # 1 hour in seconds

# it turns out, the latest sunrise in 2021 was at 8:25.
# i never want to wake up in the dark, so let's ensure I wake at 8:30 instead.
sleep 1800s # 30 minutes in seconds

# HACK: this script is for happy pills, i want that to happen at 20 past 9 actually.
sleep 1800s # 30 minutes in seconds, to make it 9 o'clock
sleep 1200s # 20 minutes in seconds, to make it 20 past 9.

# SCRIPT RUNS AT TWENTY PAST NINE IN THE MORNING EACH DAY, LET'S GO!

# Wake the system (find a command for this, seems rare/non-existent)
echo "wake the system command goes here"

# Restart pulse before the reminder plays,
# to ensure we don't have a repeat of that day 
# where I didn't wake up, and missed my morning estrogen.
pulseaudio -k
killall pulseaudio
pkill pulseaudio
systemctl --user stop pulseaudio.service pulseaudio.socket
systemctl --user stop pulseaudio
systemctl --user restart pulseaudio
systemctl --user restart pulseaudio.service
systemctl --user restart pulseaudio.socket

sleep 8s
sleep 8s

# Switch sound device
#pacmd set-default-sink "alsa_output.pci-0000_01_00.1.hdmi-stereo"
sleep 4s

# Unmute the speakers
amixer set Master unmute
amixer -q -D pulse sset Master unmute
pactl set-sink-mute 0 0
pactl set-sink-mute 1 0

# Speaker warming
cd "$(dirname "$0")"
paplay $(pwd)/silence.wav # Play a sound so my desktop speakers won't miss the first 3 seconds of audio if left for a while.
aplay $(pwd)/silence.wav # Play a sound so my desktop speakers won't miss the first 3 seconds of audio if left for a while.
espeak -p 66 -s 200 ". ... ."
sleep 2s

# Speaker warming 2
cd "$(dirname "$0")"
paplay $(pwd)/silence.wav # Play a sound so my desktop speakers won't miss the first 3 seconds of audio if left for a while.
aplay $(pwd)/silence.wav # Play a sound so my desktop speakers won't miss the first 3 seconds of audio if left for a while.
espeak -p 66 -s 200 ". ... ."
sleep 2s

# Set volume
echo ""
echo "Speaker volume to %!"
echo ""
amixer -D pulse sset Master 153%
pactl set-sink-volume @DEFAULT_SINK@ 153%

function flashing {
sleep 0.1
xrandr --output eDP-1 --brightness 1
xrandr --output HDMI-0 --brightness 1
xrandr --output DVI-D-0 --brightness 1
sleep 0.01
xrandr --output eDP-1 --brightness 0.3
xrandr --output HDMI-0 --brightness 0.3
xrandr --output DVI-D-0 --brightness 0.3
sleep 0.1
xrandr --output eDP-1 --brightness 1
xrandr --output HDMI-0 --brightness 1
xrandr --output DVI-D-0 --brightness 1
sleep 0.1
xrandr --output eDP-1 --brightness 0.3
xrandr --output HDMI-0 --brightness 0.3
xrandr --output DVI-D-0 --brightness 0.3
sleep 0.1
xrandr --output eDP-1 --brightness 1
xrandr --output HDMI-0 --brightness 1
xrandr --output DVI-D-0 --brightness 1
sleep 0.1
}

# Fluctuate brightness to alert me
flashing
cd "$(dirname "$0")"
# Play fly.wav with paplay
echo ""
echo Playing fly.wav!
echo ""
echo "pwd is $(pwd), User- make sure fly.wav is there."
paplay --volume=69969.420 $(pwd)/fly.wav &
aplay --volume=69969.420 $(pwd)/fly.wav &
espeak -p 66 -s 200 ". ... ."
espeak -a 200 -g 0 -p 50 -s 200 "... Meddysn."

# Fluctuate brightness to alert me
flashing

sleep 0s
espeak -a 200 -g 0 -p 50 -s 200 "... Meddysn."

# Fluctuate brightness to alert me
flashing

sleep 0s
espeak -a 200 -g 0 -p 50 -s 200 "... Meddysn."

# Fluctuate brightness to alert me
flashing

# Fluctuate brightness to alert me
flashing

# Fluctuate brightness to alert me
flashing

echo ""
echo "Removing messy non-required nohup.out!"
echo ""
rm -rf $HOME/nohup.out
rm -rf $(pwd)/nohup.out
echo "Popping zenity!"
echo ""
echo "Waiting for zenity to be dealt with (press OK or be closed), then we continue."
echo ""
notify-send "Medicine!"
sleep 0.2s
( speaker-test -t sine -f 1000 )& pid=$! ; sleep 1s ; kill -9 $pid
sleep 0.2s
( speaker-test -t sine -f 1000 )& pid=$! ; sleep 1s ; kill -9 $pid
sleep 0.2s
( speaker-test -t sine -f 1000 )& pid=$! ; sleep 1s ; kill -9 $pid
sleep 0.2s
( speaker-test -t sine -f 1000 )& pid=$! ; sleep 1s ; kill -9 $pid
sleep 0.2s
( speaker-test -t sine -f 1000 )& pid=$! ; sleep 1s ; kill -9 $pid
sleep 0.2s
( speaker-test -t sine -f 1000 )& pid=$! ; sleep 1s ; kill -9 $pid
sleep 0.2s
( speaker-test -t sine -f 1000 )& pid=$! ; sleep 1s ; kill -9 $pid
sleep 0.2s
sleep 0s && nohup zenity --warning --text "Take your mood pill. Press space 6 times to turn-off." && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out
zenity --warning --text "Take your mood pill. Press space 5 more times to turn-off..."
zenity --warning --text "Take your mood pill. Press space 4 more times to turn-off..."
zenity --warning --text "Take your mood pill. Press space 3 more times to turn-off..."
zenity --warning --text "Take your mood pill. Press space 2 more times to turn-off..."
zenity --warning --text "Take your mood pill. Press space 1 more time to turn-off..."
echo ""
rm -rf $HOME/nohup.out
rm -rf $(pwd)/nohup.out
sleep 0s
echo "Removing messy non-required nohup.out!"
echo ""
echo "Killing paplay HARD to stop fly.wav."
echo ""
pkill paplay
killall paplay
kill -9 $(pgrep paplay)
pkill aplay
killall aplay
kill -9 $(pgrep aplay)

# Amazing speech synthesis, this is.
sleep 1s
paplay $(pwd)/silence.wav # Play a sound so my desktop speakers won't miss the first 3 seconds of audio if left for a while.
aplay $(pwd)/silence.wav # Play a sound so my desktop speakers won't miss the first 3 seconds of audio if left for a while.
espeak -p 66 -s 200 ". ... ."
sleep 2s
espeak -p 66 -s 200 ". ... ."
paplay $(pwd)/silence.wav
aplay $(pwd)/silence.wav
sleep 2s
sleep 1s
sleep 2s

# Open to-do list (uncomment and change path to where your to-do list in PDF form is)
#sleep 0s && nohup atril /home/$(whoami)/Dropbox/Private-Novimatrem/my-stuff/docs/Schedule_Weekly_24_Hours_EDITED_300ppi_v20.pdf && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown

# Daily fortune
#TODAYFORT="$(fortune -a)"
#nohup zenity --warning --text "$(echo $TODAYFORT)" & nohup espeak -p 66 -s 150 -g 3 "$(echo $TODAYFORT)"

echo ""
rm -rf $HOME/nohup.out
rm -rf $(pwd)/nohup.out
sleep 0s
echo "Removing messy non-required nohup.out!"
echo ""

killall espeak
killall speech-dispatcher

exit
