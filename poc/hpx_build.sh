#!/usr/bin/env bash
# HPX Build Script for Compiler Explorer PoC
# This builds HPX 2.0.0 with flags aligned to the godbolt-minimal CMake preset.
#
# Usage: ./hpx_build.sh [/path/to/hpx/source]
#
# Prerequisites:
#   - CMake >= 3.18
#   - Ninja
#   - Boost >= 1.71 (headers)
#   - A C++20 compiler (GCC 12+ or Clang 16+)

set -euo pipefail

HPX_SOURCE="${1:-$(pwd)}"
BUILD_DIR="${HPX_SOURCE}/build/godbolt"
INSTALL_PREFIX="/tmp/hpx-local"

echo "=== HPX Build for Compiler Explorer ==="
echo "Source:  ${HPX_SOURCE}"
echo "Build:   ${BUILD_DIR}"
echo "Install: ${INSTALL_PREFIX}"
echo ""

cmake -S "${HPX_SOURCE}" -B "${BUILD_DIR}" \
  -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DHPX_WITH_STATIC_LINKING=OFF \
  -DHPX_WITH_DISTRIBUTED_RUNTIME=OFF \
  -DHPX_WITH_NETWORKING=OFF \
  -DHPX_WITH_TESTS=OFF \
  -DHPX_WITH_EXAMPLES=OFF \
  -DHPX_WITH_FETCH_ASIO=ON \
  -DHPX_WITH_MALLOC=system \
  -DHPX_WITH_CXX_STANDARD=20 \
  -DCMAKE_INSTALL_PREFIX="${INSTALL_PREFIX}"

echo ""
echo "=== Building... ==="
cmake --build "${BUILD_DIR}" -j"$(nproc 2>/dev/null || sysctl -n hw.ncpu)"

echo ""
echo "=== Installing to ${INSTALL_PREFIX}... ==="
cmake --install "${BUILD_DIR}"

echo ""
echo "=== Done! ==="
echo "HPX installed to: ${INSTALL_PREFIX}"
echo "Include: ${INSTALL_PREFIX}/include"
echo "Lib:     ${INSTALL_PREFIX}/lib"
