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

# Get the current time in 24 hours as a number.
TIMEHOURTIMEKEEPING="$( date +'%H')"

# Debug, comment out in final, comment out above if using for testing.
#TIMEHOURTIMEKEEPING="$(echo 06)"
#TIMEMINUTETIMEKEEPING="$(echo 59)"



# If not time hour at 07 (7 am), exit.
if ! [ "$TIMEHOURTIMEKEEPING" == "06" ]; then exit; fi

# If time hour is at 07 (7 am), continue.
if [ "$TIMEHOURTIMEKEEPING" == "06" ]; then echo "Running noisemaker!"; fi

# Play sound and show zenity box
if [ "$TIMEHOURTIMEKEEPING" == "06" ]; then bash noisemaker.sh; fi

# If not time hour 07 (7 am), sleep repeatedly until it changes.
if ! [ "$TIMEHOURTIMEKEEPING" == "06" ]; then while ! $TIMEHOURTIMEKEEPING == "*"; do sleep 1; done; fi

# The user dealt with Zenity, we kill music BUT NOT THE WHOLE SCRIPT, then resume as normal checking for time.
echo ""

echo "Killing paplay HARD to stop fly.wav."
echo ""
pkill paplay
killall paplay
kill -9 $(pgrep paplay)
pkill aplay
killall aplay
kill -9 $(pgrep aplay)

echo ""

# Sleep for an hour and 2 mins to avoid accidental re-trigger
echo "Sleeping for 62 mins before checking for another."
sleep 3720s

exit
