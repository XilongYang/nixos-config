#!/usr/bin/env bash
set -euo pipefail

# 查找电池路径
BAT=${BAT:-/sys/class/power_supply/BAT0}
if [ ! -f "$BAT/capacity" ]; then
  echo '{"text":"󰂎","tooltip":"No battery","class":"nobat"}'
  exit 0
fi

# 读取电池信息
CAP=$(cat "$BAT/capacity")
STATUS=$(cat "$BAT/status" 2>/dev/null || echo "Unknown")

# 计算剩余时间
ENOW=$(cat "$BAT/energy_now")
PNOW=$(cat "$BAT/power_now")
EFULL=$(cat "$BAT/energy_full")

if [ "$STATUS" = "Discharging" ]; then
  sec=$(( ENOW * 3600 / PNOW ))
elif [[ "$STATUS" = "Charging"  ||  "$STATUS" = "Full" ]]; then
  sec=$(( (EFULL - ENOW) * 3600 / PNOW ))
fi
TIME=$(printf "%dh %02dm" $((sec/3600)) $((sec%3600/60)) 2>/dev/null || true)

# 选择图标
ICONS=( "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" )
idx=$(( CAP * ${#ICONS[@]} / 100 ))
[ "$idx" -ge "${#ICONS[@]}" ] && idx=$(( ${#ICONS[@]} - 1 ))
[ "$idx" -lt 0 ] && idx=0

icon=${ICONS[$idx]}

CHARGE_ICONS=( "󰢟" "󰢜" "󰂆" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" )
if [ "$STATUS" = "Charging" ]; then
  idx=$(( CAP * ${#CHARGE_ICONS[@]} / 100 ))
  [ "$idx" -ge "${#CHARGE_ICONS[@]}" ] && idx=$(( ${#CHARGE_ICONS[@]} - 1 ))
  [ "$idx" -lt 0 ] && idx=0
  icon=${CHARGE_ICONS[$idx]}
fi

# 设置状态类别
class="normal"
if [ "$STATUS" = "Charging" ] || [ "$STATUS" = "Full" ]; then class="charging"
elif [ "$CAP" -le 5 ];  then class="critical"
elif [ "$CAP" -le 15 ]; then class="warning"
fi

# 发送低电量通知
TIMESTAMP=/tmp/battery_alert_timestamp
DURATION=$(($(date +%s) - $(cat "$TIMESTAMP" 2>/dev/null || echo 0)))

if [ "$STATUS" = "Discharging" ]; then
  interval=0
  title=""
  body="Battery at ${CAP}%"
  
  if [ "$CAP" -le 2 ]; then
    interval=10
    title="Battery Critical"
  elif [ "$CAP" -le 5 ]; then
    interval=60
    title="Battery Very Low"
  elif [ "$CAP" -le 15 ]; then
    interval=600
    title="Battery Low"
  fi
  
  if [ -n "$title" ] && [ "$DURATION" -ge "$interval" ]; then
    notify-send -u critical "$title" "$body"
    echo "$(date +%s)" > "$TIMESTAMP"
    mpv ~/.config/waybar/assets/ringing.wav
  fi
fi

tooltip="${CAP}%, ${STATUS}, ${TIME:-}"

printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' "$icon" "$tooltip" "$class"
