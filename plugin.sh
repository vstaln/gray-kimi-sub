#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/kimi-sub.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/kimi-sub" ;;
    *) rel="x86_64-apple-darwin/kimi-sub" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/kimi-sub" ;;
    *) rel="x86_64-unknown-linux-musl/kimi-sub" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/kimi-sub.exe" "$here/target/release/kimi-sub" "$here/target/debug/kimi-sub.exe" "$here/target/debug/kimi-sub"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "kimi-sub binary not found in $here" >&2
exit 1
