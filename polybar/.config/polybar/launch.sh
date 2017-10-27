# kill already running bars
killall -q polybar

# wait
while pgrep -x polybar > /dev/null; do sleep 1; done

# launch
for i in $(polybar -m | awk -F: '{print $1}'); do MONITOR=$i polybar top -c ~/.config/polybar/config & done