#!/usr/bin/env bash
# =============================================================================
# build_hpx.sh — Build & install HPX 2.x for local Compiler Explorer use
#
# Usage:
#   chmod +x scripts/build_hpx.sh
#   ./scripts/build_hpx.sh [install_prefix]
#
# Default install prefix: /tmp/hpx-local
# Requires: cmake, ninja (or make), clang++, Boost (brew install boost)
# =============================================================================
set -euo pipefail

INSTALL_PREFIX="${1:-/tmp/hpx-local}"
HPX_SRC="${HPX_SRC:-$HOME/Desktop/Jatin/hpx}"   # adjust to your HPX clone

echo "==> Building HPX from: $HPX_SRC"
echo "==> Installing to:      $INSTALL_PREFIX"

BUILD_DIR="$(mktemp -d)/hpx-build"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

cmake "$HPX_SRC" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
  -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
  -DHPX_WITH_FETCH_ASIO=ON \
  -DHPX_WITH_STATIC_LINKING=OFF \
  -DHPX_WITH_DISTRIBUTED_RUNTIME=OFF \
  -DHPX_WITH_NETWORKING=OFF \
  -DHPX_WITH_TESTS=OFF \
  -DHPX_WITH_EXAMPLES=OFF \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

cmake --build . --parallel "$(sysctl -n hw.logicalcpu 2>/dev/null || nproc)"
cmake --install .

echo ""
echo "==> HPX installed to: $INSTALL_PREFIX"
echo "==> Headers: $INSTALL_PREFIX/include/hpx/"
echo "==> Libs:    $INSTALL_PREFIX/lib/"
echo ""
echo "==> Now update config/c++.local.properties with:"
echo "    libs.hpx.versions.200.path=$INSTALL_PREFIX/include:/opt/homebrew/include"
echo "    libs.hpx.versions.200.libpath=$INSTALL_PREFIX/lib:/opt/homebrew/lib"
