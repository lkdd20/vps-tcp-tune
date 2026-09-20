#!/usr/bin/env bash
set -euo pipefail

URL="https://raw.githubusercontent.com/lkdd20/vps-tcp-tune/main/net-tcp-tune-r6.4-yongge-menu3.sh"
TARGET="/usr/local/bin/sbb"
TMP="$(mktemp)"

cleanup() {
  rm -f "$TMP"
}
trap cleanup EXIT

if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$URL" -o "$TMP"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$TMP" "$URL"
else
  echo "需要 curl 或 wget 才能下载安装。" >&2
  exit 1
fi

bash -n "$TMP"
install -m 0755 "$TMP" "$TARGET"

echo "安装完成：$TARGET"
echo "以后直接输入：sbb"
