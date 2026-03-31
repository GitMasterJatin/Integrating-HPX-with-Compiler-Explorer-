# Integrating HPX with Compiler Explorer

A proof-of-concept that adds **HPX 2.0.0** as a usable library inside a local [Compiler Explorer](https://github.com/compiler-explorer/compiler-explorer) instance — part of a GSoC 2026 proposal to bring HPX to [godbolt.org](https://godbolt.org).

## What this demonstrates

| Feature | Status |
|---|---|
| HPX 2.0.0 registered as a CE library | ✅ |
| `hpx::transform_reduce` compiles in CE | ✅ |
| Parallel execution policy (`hpx::execution::par`) | ✅ |
| Program output visible in CE execution pane | ✅ |
| CE running locally at `http://localhost:10240` | ✅ |

**Verified output:**
```
Sum of squares: 204   # = 1²+2²+3²+4²+5²+6²+7²+8²
```

---

## Repository structure

```
.
├── config/
│   └── c++.local.properties   # CE library config for HPX (drop-in for etc/config/)
├── examples/
│   ├── transform_reduce.cpp   # hpx::transform_reduce with parallel policy
│   └── parallel_for_each.cpp  # hpx::for_each with parallel policy
├── scripts/
│   ├── build_hpx.sh           # Build & install HPX 2.x from source
│   ├── start_ce.sh            # Start CE with HPX config injected
│   └── test_hpx_ce.py         # API smoke-test: compile + execute via CE REST API
└── README.md
```

---

## Prerequisites

| Tool | Version tested | Notes |
|---|---|---|
| macOS | 14+ (Sonoma) | Linux works too — see notes |
| Xcode CLT / clang++ | 17.0.0 | `xcode-select --install` |
| CMake | ≥ 3.25 | `brew install cmake` |
| Boost | 1.90.0 | `brew install boost` |
| Node.js | 22.x | `brew install node` |
| Python | 3.10+ | for test script |
| git | any | |

---

## Quick start

### Step 1 — Clone Compiler Explorer

```bash
git clone --depth 1 https://github.com/compiler-explorer/compiler-explorer
cd compiler-explorer
npm install
```

### Step 2 — Build & install HPX

Clone HPX source:
```bash
git clone --depth 1 https://github.com/STEllAR-GROUP/hpx
```

Then build (adjust `HPX_SRC` to your clone path):
```bash
HPX_SRC=~/path/to/hpx ./scripts/build_hpx.sh /tmp/hpx-local
```

This configures HPX with:
- `HPX_WITH_FETCH_ASIO=ON` (self-contained, no system Asio needed)
- `HPX_WITH_DISTRIBUTED_RUNTIME=OFF` (minimal, CE only needs local parallelism)
- `HPX_WITH_NETWORKING=OFF`
- `HPX_WITH_STATIC_LINKING=OFF` (shared libs, suitable for local use)

HPX headers land in `/tmp/hpx-local/include/hpx/`, libs in `/tmp/hpx-local/lib/`.

### Step 3 — Install the CE config

```bash
cp config/c++.local.properties  /path/to/compiler-explorer/etc/config/
```

Or let the start script do it automatically:

```bash
chmod +x scripts/start_ce.sh
./scripts/start_ce.sh /path/to/compiler-explorer 10240
```

### Step 4 — Verify

```bash
python3 scripts/test_hpx_ce.py http://localhost:10240
```

Expected output:
```
Testing HPX in Compiler Explorer at http://localhost:10240

Library: PASS  (HPX 2.0.0 (local) registered)
Compile: PASS  (exit 0)
Execute: PASS  (exit 0)
Output:  Sum of squares: 204

All checks PASSED ✓
```

---

## How the CE config works

`config/c++.local.properties` is loaded by CE at startup as the *local* override layer (highest priority in the config hierarchy). It defines:

```properties
# Two include paths: HPX headers + Boost headers
libs.hpx.versions.200.path=/tmp/hpx-local/include:/opt/homebrew/include

# Library paths
libs.hpx.versions.200.libpath=/tmp/hpx-local/lib:/opt/homebrew/lib

# Link order (critical): wrap → init → core → hpx
libs.hpx.versions.200.liblink=hpx_wrap:hpx_init:hpx_core:hpx

# Compiler/linker flags
# -Wl,-e,_initialize_main  : macOS entry-point wrap for hpx_main.hpp
# On Linux use: -Wl,-wrap=main instead
libs.hpx.versions.200.options=-DHPX_APPLICATION_EXPORTS -std=c++20 -Wl,-e,_initialize_main
```

### macOS vs Linux linker flag

| Platform | Flag | Purpose |
|---|---|---|
| **macOS** | `-Wl,-e,_initialize_main` | Redirects entry point so HPX can wrap `main()` |
| **Linux** | `-Wl,-wrap=main` | Same purpose via GNU linker |

---

## Example: transform_reduce

```cpp
#include <hpx/hpx_main.hpp>
#include <hpx/numeric.hpp>
#include <hpx/algorithm.hpp>
#include <vector>
#include <iostream>

int main() {
    std::vector<int> v = {1, 2, 3, 4, 5, 6, 7, 8};

    auto result = hpx::transform_reduce(
        hpx::execution::par,      // parallel execution policy
        v.begin(), v.end(),
        0,
        std::plus<>{},
        [](int x) { return x * x; });

    std::cout << "Sum of squares: " << result << std::endl;
    return 0;
}
```

**Compiler flags:** `-std=c++20 -DHPX_APPLICATION_EXPORTS`  
**Library:** HPX 2.0.0  
**Output:** `Sum of squares: 204`

---

## Known issues & what this GSoC project fixes

The current HPX entry in `godbolt.org`'s production config (`c++.amazon.properties`) has several bugs this project targets:

| Bug | Current state | Fix |
|---|---|---|
| Hardcoded Boost path | `/opt/compiler-explorer/libs/boost_1_84_0` | Use `%DEP0%` substitution |
| Dynamic linking | `liblink=` (shared) | Change to `staticliblink=` for nsjail |
| Stale version | v1.11.0 only | Add v2.0.0 with proper CMake preset |
| No `skip_compilers` | Fails on pre-C++17 compilers | Add `skip_compilers=...` filter |
| No default example | Blank editor on open | Add `defaultExample` with transform_reduce |
| Missing `godbolt-minimal` preset | HPX source has no CE-optimised preset | Add preset to HPX source tree |

---

## GSoC 2026 context

This repository is the **working proof-of-concept** for the GSoC 2026 proposal:  
**"Add HPX to Compiler Explorer"** — STEllAR-GROUP / HPX project.

The proposal covers 7 deliverables (D1–D7) submitted to [GSoC 2026](https://summerofcode.withgoogle.com/):

- **D1** Static HPX build preset (`godbolt-minimal`) in HPX source tree  
- **D2** Fix upstream `c++.amazon.properties` HPX entry (static linking, v2.0+)  
- **D3** Fix `libraries.yaml` in `compiler-explorer/infra`  
- **D4** CE-side C++ type system for HPX parallel algorithms  
- **D5** Default example snippets for HPX in CE  
- **D6** CI smoke-tests in CE test suite  
- **D7** Documentation & upstream PR  

---

## License

MIT — see [LICENSE](LICENSE)
