#!/usr/bin/env bash
# =============================================================================
# start_ce.sh — Start Compiler Explorer with local HPX config
#
# Usage:
#   chmod +x scripts/start_ce.sh
#   ./scripts/start_ce.sh [ce_dir] [port]
#
# Default CE directory:  ~/Desktop/Jatin/compiler-explorer
# Default port:          10240
# =============================================================================
set -euo pipefail

CE_DIR="${1:-$HOME/Desktop/Jatin/compiler-explorer}"
PORT="${2:-10240}"
CONFIG_SRC="$(cd "$(dirname "$0")/.." && pwd)/config/c++.local.properties"
CONFIG_DEST="$CE_DIR/etc/config/c++.local.properties"

# Verify CE is cloned
if [[ ! -f "$CE_DIR/app.ts" ]]; then
  echo "ERROR: Compiler Explorer not found at $CE_DIR"
  echo "Clone it with:"
  echo "  git clone --depth 1 https://github.com/compiler-explorer/compiler-explorer $CE_DIR"
  echo "  cd $CE_DIR && npm install"
  exit 1
fi

# Verify HPX is installed
HPX_INCLUDE=$(grep "versions.200.path" "$CONFIG_SRC" | cut -d= -f2 | cut -d: -f1)
if [[ ! -d "$HPX_INCLUDE/hpx" ]]; then
  echo "ERROR: HPX headers not found at $HPX_INCLUDE/hpx"
  echo "Run: ./scripts/build_hpx.sh"
  exit 1
fi

# Copy config into CE
cp "$CONFIG_SRC" "$CONFIG_DEST"
echo "==> Copied HPX config to $CONFIG_DEST"

# Start CE
echo "==> Starting Compiler Explorer on http://localhost:$PORT"
echo "==> Press Ctrl+C to stop"
echo ""
cd "$CE_DIR"
exec ./node_modules/.bin/tsx app.ts --port "$PORT"
