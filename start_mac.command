#!/bin/bash
cd "$(dirname "$0")"
PORT=8765

PYTHON_BIN=""
if command -v python3 >/dev/null 2>&1; then
  PYTHON_BIN="python3"
elif command -v python >/dev/null 2>&1; then
  PYTHON_BIN="python"
fi

if [ -z "$PYTHON_BIN" ]; then
  echo ""
  echo "[ERROR] Python 3 was not found on this Mac."
  echo "Try opening Terminal and running: python3 --version"
  echo "macOS will usually offer to install the required Command Line Tools."
  echo "Once that finishes, run this file again."
  echo ""
  read -p "Press Enter to close this window..."
  exit 1
fi

echo "============================================"
echo " Bookstore Inventory System - Starting Up"
echo "============================================"
echo "Starting a local server on http://localhost:$PORT"
echo "(This only serves files on this Mac. Nothing goes over the internet.)"
echo ""

"$PYTHON_BIN" -m http.server "$PORT" --bind 127.0.0.1 --directory "$(pwd)" &
SERVER_PID=$!
sleep 1
open "http://127.0.0.1:$PORT/index.html"

echo "The app is now open in your browser."
echo "Keep this window open while you use the app."
echo "To stop, close this window or press Ctrl+C."
echo ""

trap "kill $SERVER_PID 2>/dev/null" EXIT
wait $SERVER_PID
