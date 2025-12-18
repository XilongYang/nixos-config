#!/usr/bin/env bash
set -euo pipefail

# ---- helpers ----
json_escape() {
  # minimal JSON escaping for tooltip text
  sed -e 's/\\/\\\\/g' -e 's/"/\\"/g'
}

# ---- detect active recording stream + recorded device ----
DUMP="$(pw-dump 2>/dev/null || true)"
[ -z "$DUMP" ] && exit 0

# 找到第一个“正在运行”的音频输入流（录音流）
STREAM_IDS="$(
  echo "$DUMP" | jq -r '
    .[]
    | select(.type=="PipeWire:Interface:Node")
    | select(.info.props["media.class"]=="Stream/Input/Audio")
    | select((.info.state // "")=="running")
    | .id'
)"

# 没有录音流 => 不显示
[ -z "${STREAM_IDS:-}" ] && exit 0

# 遍历所有录音流，找出对应的录音设备
# 存放在变量中
RESULTS=""
for SID in $STREAM_IDS; do
  # 排除MONITOR流（系统播放的声音被录制）
  IS_MONITOR="$(
    echo "$DUMP" | jq -r --arg sid "$SID" '
      .[]
      | select(.type=="PipeWire:Interface:Node")
      | select((.id|tostring)==$sid)
      | (.info.props["media.class"] // "") | test("Monitor")
    '
  )"
  if [ "$IS_MONITOR" == "true" ]; then
      break
  fi

  CALLER_NAME="$(
    echo "$DUMP" | jq -r --arg nid "$SID" '
      .[]
      | select(.type=="PipeWire:Interface:Node")
      | select((.id|tostring)==$nid)
      | (.info.props["node.description"] // .info.props["node.nick"] // .info.props["node.name"] // "")
    '
  )"
  # 追溯录音流连接到了哪个 Audio/Source
  # PipeWire Link 通常是：source(output) -> stream(input)
  SOURCE_IDS="$(
    echo "$DUMP" | jq -r --arg sid "$SID" '
      .[]
      | select(.type=="PipeWire:Interface:Link")
      | .info.props as $p
      | select( ($p["link.input.node"]|tostring)==$sid
             or ($p["link.output.node"]|tostring)==$sid
        )
      | (
          if ($p["link.input.node"]|tostring)==$sid 
          then ($p["link.output.node"]|tostring)
          else ($p["link.input.node"]|tostring)
          end
        )' | sort -n | uniq
    )"

  for SOURCE_ID in $SOURCE_IDS; do
    # 从 source node 拿到可读设备名
    DEVICE_NAME=""
    if [ -n "${SOURCE_ID:-}" ]; then
      DEVICE_NAME="$(
        echo "$DUMP" | jq -r --arg nid "$SOURCE_ID" '
          .[]
          | select(.type=="PipeWire:Interface:Node")
          | select((.id|tostring)==$nid)
          | (.info.props["node.description"] // .info.props["node.nick"] // .info.props["node.name"] // "")
        '
      )"
    fi
    MEDIA_TYPE="$(
      echo "$DUMP" | jq -r --arg sid "$SOURCE_ID" '
      .[] 
      | select(.type=="PipeWire:Interface:Node" 
        and (.id|tostring)==$sid) 
      | .info.props["media.class"]')"

    if [[ $MEDIA_TYPE == Audio/Source* ]]; then
      RESULTS+="$SID|$CALLER_NAME|$SOURCE_ID|$DEVICE_NAME|$MEDIA_TYPE;"
    fi
  done
done

if [ -z "$RESULTS" ]; then
  # 没有找到有效的录音流和设备，退出
  exit 0
fi

# ---- mic mute state (default source) ----
OUT="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null || true)"
if echo "$OUT" | grep -q '\[MUTED\]'; then
  ICON="󰍭"
  STATE="muted"
else
  ICON="󰍬"
  STATE="active"
fi

TOOLTIP=$(
  echo "$RESULTS" \
  | tr ';' '\n' \
  | sed '/^$/d' \
  | awk -F'|' '{ printf "%s:%s => %s:%s(%s)\n", $1, $2, $3, $4, $5 }'
)

printf "{\"text\": \"%s\", \"tooltip\": \"%s\", \"class\": \"mic-%s\"}\n" \
  "$ICON" \
  "$TOOLTIP" \
  "$STATE"
