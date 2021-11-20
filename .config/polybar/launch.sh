#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# # Launch bar1 and bar2
# echo "---" | tee -a /tmp/polybar1$USER.log /tmp/polybar2$USER.log
# polybar black >>/tmp/polybar1$USER.log 2>&1 & disown
# #polybar top-panel >>/tmp/polybar2.log 2>&1 & disown

# echo "---" | tee -a "/tmp/polybar1$USER.log" /tmp/polybar2$USER.log
# polybar black-top >>/tmp/polybar1$USER.log 2>&1 & disown


# echo "Bars launched..."


if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload black &
    # MONITOR=$m polybar --reload black-top &
  done
else
  polybar --reload black &
  # polybar --reload black-top &
fi

setmonitor.sh