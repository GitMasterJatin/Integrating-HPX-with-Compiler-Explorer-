# Integrating HPX with Compiler Explorer

> **GSoC 2026 Proof of Concept**

A working proof of concept integrating **HPX 2.0.0** into a local Compiler Explorer instance.
HPX compiles, links, and executes inside CE with correct assembly output.

The existing HPX entry on godbolt.org is broken due to six bugs (hardcoded Boost paths,
dynamic linking, outdated version, etc.). This repo contains the fixes.

## Repository Structure

```
poc/
  c++.local.properties          # Drop-in CE config (tested and working)
  hpx_build.sh                  # Build HPX for CE
  proposed_libraries.yaml       # Proposed CE infra YAML entry
examples/
  transform_reduce.cpp          # Default CE example for HPX
```

## Quick Start

### 1. Build HPX

```bash
git clone https://github.com/STEllAR-GROUP/hpx.git && cd hpx
bash /path/to/this/repo/poc/hpx_build.sh .
```

### 2. Set Up Compiler Explorer

```bash
git clone https://github.com/compiler-explorer/compiler-explorer.git
cd compiler-explorer
cp /path/to/this/repo/poc/c++.local.properties etc/config/
make dev
```

### 3. Test

Open http://localhost:10240, select HPX from the Libraries dropdown,
paste `examples/transform_reduce.cpp`, and click Run.

## Bugs Fixed

| # | Problem | Fix |
|---|---------|-----|
| 1 | Hardcoded Boost 1.84 path | %DEP0% interpolation |
| 2 | Dynamic linking in static sandbox | staticliblink + STATIC_LINKING=ON |
| 3 | Only v1.11.0 | v2.0.0 primary, v1.11.0 fallback |
| 4 | No skip_compilers | GCC 11 and below, Clang 14 and below excluded |
| 5 | No default example | transform_reduce with sandbox.hpp |
| 6 | sandbox.hpp undiscoverable | Default example includes it |

## Links

- [HPX](https://github.com/STEllAR-GROUP/hpx)
- [Compiler Explorer](https://github.com/compiler-explorer/compiler-explorer)
