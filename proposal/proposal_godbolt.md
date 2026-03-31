# Google Summer of Code 2026 — HPX / STE||AR Group

## Add HPX to Compiler Explorer (godbolt.org)

---

**Applicant:** Jatin Sharma
**University:** Indian Institute of Technology (BHU), Varanasi
**Programme:** Integrated Dual Degree (Graduating 2027)
**Email:** [jatin.sharma.cd.civ22@itbhu.ac.in](mailto:jatin.sharma.cd.civ22@itbhu.ac.in)
**GitHub:** [github.com/GitMasterJatin](https://github.com/GitMasterJatin)
**LinkedIn:** [linkedin.com/in/jatin-sharma-70a26825b](https://www.linkedin.com/in/jatin-sharma-70a26825b/)
**Website:** [www.sharmajatin.com](https://www.sharmajatin.com)
**Phone:** (+91) 9996499472
**Project size:** Medium (175 hours)

---

## 1. Background Information

### Education

**Integrated Dual Degree** — Indian Institute of Technology (BHU), Varanasi *(Graduating 2027)*

My coursework covers algorithms, operating systems, parallel computing, and computer architecture — all of which feed directly into this project's challenges around build systems, infrastructure automation, and making a complex parallel runtime accessible through the web.

### Work Experience

**Software Development Intern** | *Fiverse*

- Built a full-stack investor–company matching platform (MERN stack) with 15+ REST endpoints, secure file uploads, and an Nginx reverse proxy for load distribution.
- **Relevant to this project:** Hands-on experience with Node.js backend architecture, which is exactly what Compiler Explorer's main application runs on. Understanding Nginx and reverse proxies helps with reasoning about CE's deployment infrastructure.

### Relevant Projects

**Order Execution and Management System (C++)**
- Developed low-latency features for order placement, modification, order book retrieval, and position tracking across crypto futures, options, and spot trading.
- Reduced latency using multithreading, asynchronous HTTP requests, data compression, and thread-safe data structures.
- **Why it matters here:** This is where I learnt the pain of integrating complex C++ libraries into build systems under tight constraints — exactly the problem this project solves for HPX on CE.

**SyncCanvas — Real-Time Collaborative Drawing Platform**
- Built a full-stack real-time drawing app with WebSockets, infinite canvas, and multi-user sync. Managed as a monorepo (Turborepo + pnpm) with shared types.
- **Tech Stack:** Next.js, WebSocket, PostgreSQL, Turborepo, pnpm, Canvas API, AWS.
- **Why it matters here:** The monorepo architecture and Node.js/TypeScript tooling directly mirrors Compiler Explorer's own codebase structure.

### Technical Skills

- **C++ (3+ years):** Modern C++ (C++17/20) — template metaprogramming, lock-free data structures, parallel algorithms. Through my HPX contributions I work regularly with iterators, type traits, and low-level memory utilities.
- **Build Systems:** CMake (including FetchContent, ExternalProject), Conan package manager, Ninja. I've spent hours debugging HPX's own CMake build — that experience is central to getting HPX to build correctly on CE's infrastructure.
- **Node.js / TypeScript:** Production experience from Fiverse and SyncCanvas. CE's main application is TypeScript — I can read and modify `options-handler.ts` and `base-compiler.ts` without a steep learning curve.
- **Infrastructure:** Docker, Nginx, AWS. Comfortable with the kind of Linux-based build pipelines CE uses.
- **Tools:** Git/GitHub workflows, Linux, gdb, Valgrind, VS Code.

**Open-Source Project:** [Parallel matrix multiplication in HPX](https://github.com/GitMasterJatin/Parallel-matrix-multiplication-implemented-in-HPX) (GitHub)

### Why This Project

I'll be honest: what drew me to this specific project was frustration. When I started contributing to HPX, I wanted to share a quick snippet with a friend — "look, this parallel `transform_reduce` is faster than the sequential version" — and my first instinct was to open Compiler Explorer. I searched for HPX in the library dropdown, and... nothing worked. The library entry exists, but selecting it doesn't produce a working compilation. I had to resort to sharing a screenshot of my terminal instead.

That experience stuck with me. HPX is arguably the most complete implementation of the C++ parallel algorithms standard — it runs on commodity hardware, no GPU required, no vendor lock-in — and yet the simplest way to try it is a 30-minute build from source. Every other major parallel framework (Kokkos, TBB, even Thrust) is a checkbox away on CE. HPX deserves the same.

This project also sits right at the intersection of things I've been building skills in: C++ build systems (from my HPX contributions), Node.js backend architecture (from Fiverse), and infrastructure automation. Making a large, dependency-heavy runtime "just work" inside a sandboxed web environment is a genuinely interesting engineering problem.

### Contributions to HPX

I've been active in the STE||AR Group community for the past several months — Discord, mailing list, and code contributions:

| # | Pull Request | Status |
|---|-------------|--------|
| 1 | Fix heap corruption in `partial_sort` `filter()` function [#7051](https://github.com/STEllAR-GROUP/hpx/pull/7051) | **Merged** |
| 2 | cmake: remove `HPX_WITH_CXX20_STD_RANGES_ITER_SWAP` feature test [#7032](https://github.com/STEllAR-GROUP/hpx/pull/7032) | **Merged** |
| 3 | Fix numa allocator test [#7027](https://github.com/STEllAR-GROUP/hpx/pull/7027) | **Merged** |
| 4 | Fix heap corruption and out-of-bounds in `sort_thread` partitioning [#7018](https://github.com/STEllAR-GROUP/hpx/pull/7018) | **Merged** |
| 5 | cmake: remove `HPX_WITH_CXX20_SOURCE_LOCATION` test [#6996](https://github.com/STEllAR-GROUP/hpx/pull/6996) | **Merged** |
| 6 | cmake: remove `HPX_WITH_CXX20_STD_DEFAULT_SENTINEL` test [#6977](https://github.com/STEllAR-GROUP/hpx/pull/6977) | **Merged** |
| 7 | cmake: remove `HPX_WITH_CXX20_STD_BIT_CAST` test [#6976](https://github.com/STEllAR-GROUP/hpx/pull/6976) | **Merged** |
| 8 | Convert `enum message_buffer_append_state` to `enum class` [#6923](https://github.com/STEllAR-GROUP/hpx/pull/6923) | **Merged** |
| 9 | Add subtraction unit tests for `gid_type` [#6913](https://github.com/STEllAR-GROUP/hpx/pull/6913) | **Merged** |
| 10 | Removed the incomplete line in README [#6898](https://github.com/STEllAR-GROUP/hpx/pull/6898) | **Merged** |
| 11 | Improve SPSC queue performance in work-requesting scheduler [#7114](https://github.com/STEllAR-GROUP/hpx/pull/7114) | **Open** |

*(10 merged, 1 open)*

Notably, several of these contributions are CMake-related (#7032, #6996, #6977, #6976) — I've spent real time inside HPX's build system, which is directly relevant to getting the Compiler Explorer build configuration right. The algorithm fixes (#7051, #7018) show I can read and reason about HPX's internal code, and the SPSC queue PR (#7114) shows I'm comfortable with performance-sensitive work.

### Plans Beyond GSoC

I'm committed to maintaining this integration after GSoC ends. HPX releases roughly twice a year, and each new release needs a small update to CE's configuration — adding the new version tag, verifying the build, and submitting PRs. This is a 1–2 hour task that I'll keep doing as long as I'm part of the community (and I intend to be).

I also plan to contribute back to Compiler Explorer's documentation for complex compiled-library integrations. The current docs (`AddingALibrary.md`) cover simple cases well but don't address the challenges of runtime-dependent libraries like HPX. I want to document what I learn so the next person who tries to add a complex library has a better starting point.

---

## 2. Project Proposal

### 2.1 The Problem: HPX is Invisible to Casual C++ Developers

Compiler Explorer (godbolt.org) is where modern C++ lives. Over 3.5 million unique users per month use it to compile, run, and inspect C++ code — no local setup required. Conference speakers embed CE links in their slides. The C++ Standards Committee uses CE to evaluate proposals. Library authors treat CE presence as table stakes: if your library isn't on CE, most developers will never try it.

HPX provides a complete implementation of the C++ Standard Library parallel algorithms (`hpx::for_each`, `hpx::transform_reduce`, `hpx::sort`, etc.), task-based parallelism with futures and continuations, and an asynchronous many-task runtime with work-stealing scheduling. It's one of the most sophisticated parallel frameworks in the C++ ecosystem. But a developer who wants to try `hpx::for_each(hpx::execution::par, ...)` faces this:

1. Clone the HPX repository
2. Install Boost (compiled libraries, not just headers)
3. Install hwloc (a C library for hardware topology)
4. Install or fetch Asio
5. Configure CMake with the right options
6. Build (10–30 minutes on a modern machine)
7. Figure out that you need `#include <hpx/hpx_main.hpp>` or an explicit `hpx::init()` call

Meanwhile, a competing framework like Kokkos is one checkbox away on CE. That's the gap this project closes.

### 2.2 How Compiler Explorer's Library System Works

Before diving into the solution, it's worth understanding how CE's machinery actually works, because the integration touches every layer. I spent considerable time reading through both CE repositories to map out the full pipeline:

```
┌────────────────────────────────────────────────────────────────────────┐
│           THE LIFE OF A LIBRARY ON COMPILER EXPLORER                  │
│                                                                        │
│   STEP 1: Define the library                                          │
│   ┌────────────────────────────────────┐                              │
│   │  compiler-explorer/infra           │                              │
│   │  bin/yaml/libraries.yaml           │                              │
│   │                                    │                              │
│   │  Each library entry specifies:     │                              │
│   │  • repo: where to fetch source     │                              │
│   │  • build_type: cmake/make/none     │                              │
│   │  • depends: other CE libraries     │                              │
│   │  • extra_cmake_arg: build flags    │                              │
│   │  • lib_type: static/shared         │                              │
│   │  • staticliblink / sharedliblink   │                              │
│   │  • skip_compilers: exclusion list  │                              │
│   │  • targets: version list           │                              │
│   └──────────────┬─────────────────────┘                              │
│                  │                                                     │
│   STEP 2: Build for every compiler                                    │
│                  ▼                                                     │
│   ┌────────────────────────────────────┐                              │
│   │  LibraryBuilder (Python)           │                              │
│   │  bin/lib/library_builder.py        │                              │
│   │                                    │                              │
│   │  For each compiler (GCC 10–15,     │                              │
│   │  Clang 12–20, etc.):              │                              │
│   │  1. Clone repo at target tag       │                              │
│   │  2. cmake configure with args      │                              │
│   │  3. Build (make/ninja)             │                              │
│   │  4. conan export-pkg               │                              │
│   │  5. Upload to Conan server         │                              │
│   │                                    │                              │
│   │  Runs nightly via crontab:         │                              │
│   │  • Popular compilers: daily        │                              │
│   │  • All compilers: Sundays          │                              │
│   └──────────────┬─────────────────────┘                              │
│                  │                                                     │
│   STEP 3: Configure the frontend                                      │
│                  ▼                                                     │
│   ┌────────────────────────────────────┐                              │
│   │  compiler-explorer/compiler-explorer│                             │
│   │  etc/config/c++.amazon.properties  │                              │
│   │                                    │                              │
│   │  libs.hpx.name=HPX                │                              │
│   │  libs.hpx.description=...         │                              │
│   │  libs.hpx.versions=200            │                              │
│   │  libs.hpx.versions.200.version=...│                              │
│   │  libs.hpx.versions.200.path=...   │                              │
│   │  libs.hpx.versions.200.           │                              │
│   │    staticliblink=...              │                              │
│   └──────────────┬─────────────────────┘                              │
│                  │                                                     │
│   STEP 4: User selects library                                        │
│                  ▼                                                     │
│   ┌────────────────────────────────────┐                              │
│   │  Runtime (TypeScript/Node.js)      │                              │
│   │                                    │                              │
│   │  options-handler.ts                │                              │
│   │  → parseLibraries() reads .props   │                              │
│   │  → Populates UI dropdown           │                              │
│   │                                    │                              │
│   │  base-compiler.ts                  │                              │
│   │  → findLibVersion() resolves ver   │                              │
│   │  → getStaticLibraryLinks() adds    │                              │
│   │    -l flags to compile command     │                              │
│   │  → Compile + link + execute        │                              │
│   └────────────────────────────────────┘                              │
└────────────────────────────────────────────────────────────────────────┘
```

The critical insight: an integration isn't just "add an entry to a YAML file." It's a coordinated change across two repositories, touching a Python build pipeline, a YAML configuration, Java-style properties files, and ultimately the TypeScript frontend. Getting any one of these wrong means the library silently fails for users.

### 2.3 What I Found: Diagnosing the Current (Broken) Integration

When I started investigating, I assumed HPX wasn't on CE at all. I was wrong — and the reality is more interesting. There *is* an HPX entry in `libraries.yaml`. Someone already did the initial work. But it doesn't produce a working integration, and understanding *why* required tracing through multiple layers.

Here's the existing entry in `compiler-explorer/infra/bin/yaml/libraries.yaml`:

```yaml
hpx:
  build_type: cmake
  check_file: CMakeLists.txt
  depends:
    - libraries/c++/boost 1.84.0
  extra_cmake_arg:
    - -DCMAKE_BUILD_TYPE=RelWithDebInfo
    - -DHPX_WITH_TESTS=OFF
    - -DHPX_WITH_EXAMPLES=OFF
    - -DHPX_WITH_CXX_STANDARD=20
    - -DHPX_WITH_FETCH_ASIO=ON
    - -DHPX_WITH_FETCH_HWLOC=ON
    - -DHPX_WITH_MALLOC=system
    - -DBOOST_ROOT=/opt/compiler-explorer/libs/boost_1_84_0/
    - -DHPX_INTERNAL_CACHE_LINE_SIZE_DETECT=64
  lib_type: shared
  make_targets:
    - all
  package_install: true
  repo: STEllAR-GROUP/hpx
  sharedliblink:
    - hpx_core
  staticliblink:
    - hpx_init
    - hpx_wrap
  target_prefix: v
  targets:
    - name: 1.11.0
  type: github
```

I read this entry and immediately spotted several issues. Let me walk through them one by one, because understanding the problems is what makes the solution precise rather than hand-wavy:

**Problem 1: The Boost path is hardcoded.** The line `-DBOOST_ROOT=/opt/compiler-explorer/libs/boost_1_84_0/` will break the moment CE updates to a newer Boost version. CE's infrastructure supports a `%DEP0%` interpolation variable that references the first entry in the `depends` list — this is how other libraries (like `boost_bin` referencing `zlib`) handle dependency paths. The hardcoded path is a ticking time bomb.

**Problem 2: `lib_type: shared` contradicts HPX's own CE preset.** HPX's `CMakePresets.json` includes a `godbolt-minimal` preset that explicitly sets `HPX_WITH_STATIC_LINKING=ON`. There's a reason for that: CE's sandboxed execution environment doesn't reliably resolve shared libraries via `LD_LIBRARY_PATH` or RPATH. The YAML entry says "shared," but HPX's own maintainers designed the CE preset for static linking. This mismatch is likely the primary cause of the integration failure — the build might succeed, but linking at execution time fails silently.

**Problem 3: Only version 1.11.0.** HPX 2.0.0 has been the current release for a while, with significant API improvements. Users who discover HPX through CE would be learning an older API.

**Problem 4: No `skip_compilers`.** HPX requires C++17 at minimum (C++20 recommended). CE hosts compilers going back to GCC 4.1 and Clang 3.0. Without a `skip_compilers` list, the build pipeline attempts to build HPX with compilers that can't possibly compile it — wasting build time and potentially causing the entire library build to be flagged as failing.

**Problem 5: No default example.** When a user selects a library on CE, the editor can auto-load example code. HPX requires either `#include <hpx/hpx_main.hpp>` (which replaces `main()` with an HPX-aware entry point) or explicit `hpx::init()` calls. A new user who selects HPX and writes `int main() { hpx::for_each(par, ...); }` will get a cryptic linker error or runtime crash. Without guidance, the library is unusable even if the build works.

**Problem 6: `sandbox.hpp` is invisible.** HPX already has a purpose-built header for CE — `hpx/experimental/sandbox.hpp` — that auto-detects the Compiler Explorer environment (via the `COMPILER_EXPLORER` environment variable), reports hardware topology, and benchmarks sequential vs. parallel execution. This is exactly what a CE user needs, but there's no way to discover it.

### 2.4 Existing Groundwork in HPX (What I'm Building On)

This project doesn't start from zero. HPX's maintainers have been laying groundwork for CE integration, and my job is to connect these pieces and make them work end-to-end.

**The `godbolt-minimal` CMake Preset** (in `CMakePresets.json`): A carefully tuned preset that strips HPX down to its essential parallel-computing core:
- `HPX_WITH_STATIC_LINKING=ON` — one set of `.a` files, no shared-library headaches
- `HPX_WITH_NETWORKING=OFF` — no TCP/MPI parcelport (CE can't do network I/O)
- `HPX_WITH_FETCH_ASIO=ON` — self-downloads Asio, removing one dependency
- `HPX_WITH_MALLOC=system` — no TCMalloc/jemalloc to install
- `HPX_WITH_TESTS/EXAMPLES/DOCUMENTATION=OFF` — minimal build scope

This preset represents the HPX maintainers' best judgment about what a CE build should look like. The existing YAML entry *doesn't use it* — it's configured differently (shared linking, `RelWithDebInfo` instead of `Release`). My solution aligns the YAML with this preset.

**The `sandbox.hpp` Header** (`libs/full/include/include/hpx/experimental/sandbox.hpp`): I read through this file carefully. It provides:
- `environment_info` — a struct reporting cores, PUs, NUMA nodes, HPX worker threads
- `check_sandbox_heuristic()` — detects `COMPILER_EXPLORER` and `HPX_SANDBOX` env vars
- `benchmark(label, seq_fn, par_fn, iterations)` — runs both functions, computes speedup and parallel efficiency, prints a formatted report
- `describe_environment(ostream)` — one-line call to print a complete environment summary

This is exactly the kind of "Hello, World" experience a CE user needs. My default example will showcase it.

**The Conan 2.x Recipe** (`conanfile.py`): A 274-line recipe with 24 configurable options. CE's build pipeline uses Conan for artifact packaging and distribution — `LibraryBuilder` runs `conan export-pkg` after each per-compiler build, then uploads to `conan.compiler-explorer.com`. HPX's recipe plugs directly into this pipeline.

**The `hpx_main.hpp` Wrapper**: Replaces `main()` so users can write `int main() { /* HPX code here */ }` and the runtime initializes automatically. This eliminates the #1 usability hurdle for CE users.

---

## 3. Description of My Solution

### 3.1 The Core Idea

The solution is a coordinated set of changes across three repositories — HPX itself, CE's infrastructure repo, and CE's main application repo — that together transform the broken YAML entry into a fully working integration. Every change I'm making has a specific, traceable reason rooted in the diagnosis above.

```
                  ┌──────────────────────────────────────┐
                  │      HPX Repository (PR #1)          │
                  │                                      │
                  │  What changes:                       │
                  │  • godbolt-minimal preset updated    │
                  │    for v2.0.0                        │
                  │  • sandbox.hpp validated & refined   │
                  │  • CE integration docs added         │
                  └───────────────┬──────────────────────┘
                                  │
                  ┌───────────────┴───────────────┐
                  │                               │
                  ▼                               ▼
  ┌──────────────────────────┐  ┌──────────────────────────────┐
  │  CE Infra (PR #2)        │  │  CE Main App (PR #3)         │
  │                          │  │                              │
  │  libraries.yaml:         │  │  c++.amazon.properties:      │
  │  • BOOST_ROOT → %DEP0%  │  │  • Library metadata          │
  │  • lib_type → static    │  │  • Version entries            │
  │  • Add v2.0.0 target    │  │  • Static link flags         │
  │  • Add skip_compilers   │  │                              │
  │  • NETWORKING=OFF       │  │  Default example:            │
  │  • DISTRIBUTED=OFF      │  │  • sandbox.hpp demo          │
  │  • make_utility: ninja  │  │  • parallel transform_reduce │
  └─────────────┬────────────┘  └──────────────┬───────────────┘
                │                              │
                └──────────────┬───────────────┘
                               ▼
                ┌──────────────────────────┐
                │  Result: HPX works on CE │
                │                          │
                │  User selects HPX v2.0.0 │
                │  → Include paths set     │
                │  → Static link flags set │
                │  → Compile + run works   │
                │  → sandbox.hpp output    │
                └──────────────────────────┘
```

### 3.2 The Fixed YAML Configuration (and Why Each Line Matters)

This is the heart of the integration. I'm going to show the complete proposed `libraries.yaml` entry, but unlike a typical config dump, I want to explain the reasoning behind each non-obvious choice. These decisions came from reading CE's `library_configuration.md`, studying how comparable libraries (Kokkos, Abseil, Boost binary) are configured, and cross-referencing with HPX's own build system.

```yaml
hpx:
  build_type: cmake
  check_file: CMakeLists.txt
  depends:
    - libraries/c++/boost_bin 1.86.0
  extra_cmake_arg:
    - -DCMAKE_BUILD_TYPE=Release
    - -DHPX_WITH_TESTS=OFF
    - -DHPX_WITH_EXAMPLES=OFF
    - -DHPX_WITH_DOCUMENTATION=OFF
    - -DHPX_WITH_CXX_STANDARD=20
    - -DHPX_WITH_FETCH_ASIO=ON
    - -DHPX_WITH_FETCH_HWLOC=ON
    - -DHPX_WITH_NETWORKING=OFF
    - -DHPX_WITH_STATIC_LINKING=ON
    - -DHPX_WITH_DISTRIBUTED_RUNTIME=OFF
    - -DHPX_WITH_MALLOC=system
    - -DBOOST_ROOT=%DEP0%
    - -DHPX_INTERNAL_CACHE_LINE_SIZE_DETECT=64
  lib_type: static
  make_targets:
    - all
  make_utility: ninja
  package_install: true
  repo: STEllAR-GROUP/hpx
  skip_compilers:
    - clang3*
    - clang4*
    - clang5*
    - clang6*
    - clang7*
    - clang8*
    - clang9*
    - gcc4*
    - gcc5*
    - gcc6*
    - gcc7*
    - gcc8*
  staticliblink:
    - hpx_core
    - hpx_init
    - hpx_wrap
  target_prefix: v
  targets:
    - 2.0.0
    - 1.11.0
  type: github
```

Let me walk through the design decisions:

**`BOOST_ROOT=%DEP0%` instead of the hardcoded path.** This is the single most critical fix. CE's `library_build_config.py` supports `%DEPn%` interpolation that resolves to the installation path of the n-th dependency in the `depends` list. When CE bumps Boost to 1.88.0, this entry will automatically pick up the new path. I confirmed this pattern by looking at how `boost_bin` uses `%DEP0%` to reference its `zlib` dependency.

**`lib_type: static` with `HPX_WITH_STATIC_LINKING=ON`.** The existing entry has `lib_type: shared` — this contradicts HPX's own `godbolt-minimal` preset and is almost certainly why the integration fails. CE's execution sandbox doesn't always set up shared library paths correctly. Static linking bundles everything into the final executable, eliminating runtime resolution entirely. I verified this by studying how Kokkos (another cmake-built, statically-linked parallel runtime) is configured — it uses `lib_type: static` with `staticliblink: [kokkoscore, kokkoscontainers, kokkossimd]`.

**`staticliblink: [hpx_core, hpx_init, hpx_wrap]`.** These are the three static libraries HPX produces. `hpx_core` is the runtime engine, `hpx_init` handles initialization, and `hpx_wrap` provides the `main()` → `hpx_main()` redirection. The order matters for the linker — `hpx_core` must come first because the others depend on it.

**`HPX_WITH_DISTRIBUTED_RUNTIME=OFF`.** CE is a single-node environment. The distributed runtime (AGAS — Active Global Address Space, parcelport layer) adds significant build time and binary size for functionality that simply can't be used in a sandbox. Disabling it cuts approximately 30% off the build time — crucial when HPX must build for 40+ compilers.

**`HPX_WITH_NETWORKING=OFF`.** Removes TCP and MPI parcelport dependencies entirely. CE's sandbox doesn't allow outbound network connections from user code.

**`make_utility: ninja`.** HPX has over 1000 source files. Ninja's superior parallel scheduling and dependency tracking roughly halves build time compared to Make. For a library that builds once per compiler, this saves significant CI time on CE's nightly build pipeline.

**`skip_compilers` with glob patterns.** HPX requires C++17 minimum. The globs `gcc4*` through `gcc8*` and `clang3*` through `clang9*` exclude compilers that can't compile HPX. I chose glob patterns rather than enumerating every compiler ID (like `clang30`, `clang31`, ..., `clang391`) because CE's build system supports them and they're more maintainable. I'll refine this list during testing — some GCC 9.x versions might also need exclusion.

**Both v2.0.0 and v1.11.0 as targets.** HPX 2.0.0 introduced API changes from the 1.x series. Users with existing 1.x code should still be able to use CE, so I'm keeping both. The default example will target the 2.0.0 API.

### 3.3 The Dependency Problem (and Three Ways to Solve It)

HPX has three runtime dependencies: Boost (compiled libraries), hwloc (a C library for hardware topology), and Asio (header-only networking). Let me walk through each:

**Boost** is straightforward. CE already maintains pre-built Boost versions (1.64.0 through 1.86.0+). HPX 2.0.0 needs Boost ≥ 1.84.0. The `depends` field in the YAML entry handles this, and `%DEP0%` gives us the path.

**Asio** is also straightforward. `HPX_WITH_FETCH_ASIO=ON` tells HPX's CMake to download Asio via `FetchContent` during configure. It's header-only, so there's nothing to compile. Network access during CMake configure is available on CE's build nodes (other libraries like `boost_bin` download `zlib` from `conan.compiler-explorer.com` during their prebuild step).

**hwloc** is the tricky one. HPX uses hwloc to discover hardware topology — how many cores, PUs, NUMA nodes, and cache levels the machine has. This information feeds into the thread-pool configuration and the scheduler's affinity decisions. The current YAML entry uses `HPX_WITH_FETCH_HWLOC=ON`, which downloads and builds hwloc at CMake configure time. But this is fragile — CE's build nodes may restrict network access during builds.

I've identified three strategies, ranked by preference:

| Strategy | How it works | Trade-offs |
|----------|-------------|-----------|
| **A. System hwloc** | Check if hwloc-dev is pre-installed on CE build nodes | Best option if available. Zero build overhead, always up to date. But requires CE infra team cooperation — I'll ask on their Discord during community bonding. |
| **B. Separate CE library entry** | Add hwloc as a `cshared` (C shared library) entry in `libraries.yaml`, built once by a fixed compiler | Clean separation, version-controlled. CE has precedent for this pattern (curl, openssl, sqlite). Slightly more setup work. |
| **C. Fetch at build time** | Keep `HPX_WITH_FETCH_HWLOC=ON` (current approach) | Simplest config, but fragile if network is restricted. I'll validate this first. |

My plan: start with Strategy C (it's what the current entry already does), test it on a CE-like environment. If it fails, fall back to Strategy B. If hwloc turns out to be pre-installed on CE nodes, Strategy A is the winner.

There's also a fallback of last resort: `HPX_WITH_HWLOC=OFF`. Without hwloc, HPX uses `std::thread::hardware_concurrency()` for topology detection and skips NUMA-aware scheduling. In a CE sandbox with 1–4 cores and a single NUMA node, this is perfectly acceptable — you lose nothing meaningful.

### 3.4 The Frontend Configuration

Once the build pipeline produces artifacts, the CE frontend needs to know how to present HPX to users. This is configured via properties files.

**Proposed entry for `etc/config/c++.amazon.properties`:**

```properties
libs.hpx.name=HPX
libs.hpx.url=https://hpx-docs.stellar-group.org/latest/html/index.html
libs.hpx.description=The C++ Standard Library for Parallelism and Concurrency
libs.hpx.versions=200:1100
libs.hpx.versions.200.version=2.0.0
libs.hpx.versions.200.staticliblink=hpx_core:hpx_init:hpx_wrap
libs.hpx.versions.200.options=-DHPX_APPLICATION_STRING="unknown" -pthread
libs.hpx.versions.1100.version=1.11.0
libs.hpx.versions.1100.staticliblink=hpx_core:hpx_init:hpx_wrap
libs.hpx.versions.1100.options=-DHPX_APPLICATION_STRING="unknown" -pthread
```

The `options` field adds two compile flags: `-DHPX_APPLICATION_STRING="unknown"` (HPX's build system requires this macro at compile time) and `-pthread` (HPX's thread pool relies on POSIX threads). These are standard flags — Boost's binary libraries use a similar pattern.

The `staticliblink` field tells `base-compiler.ts` to add `-lhpx_core -lhpx_init -lhpx_wrap` to the linker command. The colon separator (`:`) is CE's convention for listing multiple link libraries.

### 3.5 The Default Example (The First Thing Users See)

This is what makes or breaks the user experience. When someone selects HPX from the library dropdown, this code should auto-load and *just work*:

```cpp
// HPX on Compiler Explorer — Parallel Algorithm Demo
//
// This example shows HPX's parallel algorithms running inside
// Compiler Explorer. Try changing 'par' to 'seq' to compare!

#include <hpx/hpx_main.hpp>             // Auto-initializes the HPX runtime
#include <hpx/algorithm.hpp>             // Parallel algorithms (for_each, etc.)
#include <hpx/numeric.hpp>               // transform_reduce, reduce
#include <hpx/experimental/sandbox.hpp>  // CE environment detection & benchmarking

#include <iostream>
#include <numeric>
#include <vector>

int main()
{
    // Step 1: Show what environment we're running in
    hpx::experimental::sandbox::describe_environment(std::cout);

    // Step 2: Create a million doubles to work with
    constexpr std::size_t N = 1'000'000;
    std::vector<double> data(N);
    std::iota(data.begin(), data.end(), 1.0);

    // Step 3: Race sequential vs parallel — who's faster?
    auto report = hpx::experimental::sandbox::benchmark(
        "transform_reduce (1M doubles)",
        [&]() {  // Sequential version
            volatile double r = hpx::transform_reduce(
                hpx::execution::seq, data.begin(), data.end(),
                0.0, std::plus<>{}, [](double x) { return x * x; });
            (void)r;
        },
        [&]() {  // Parallel version
            volatile double r = hpx::transform_reduce(
                hpx::execution::par, data.begin(), data.end(),
                0.0, std::plus<>{}, [](double x) { return x * x; });
            (void)r;
        }
    );

    report.print(std::cout);
    return 0;
}
```

I designed this example around five principles:

1. **Zero boilerplate.** `hpx/hpx_main.hpp` handles runtime initialization. The user writes `int main()` and everything works.
2. **Immediate value.** The `sandbox::benchmark()` call produces real, tangible output — sequential time, parallel time, speedup, efficiency percentage — that demonstrates HPX's value proposition in under 10 seconds.
3. **Familiar API.** `hpx::transform_reduce` mirrors `std::transform_reduce` from C++17. A developer who knows the standard library already knows how to use this.
4. **Discoverable.** The `sandbox.hpp` include and the `describe_environment()` call show users that HPX has built-in introspection tools for CE. It encourages exploration.
5. **Fits the time budget.** CE allows ~10 seconds of execution. HPX runtime initialization takes 50–200ms. A million-element reduction with 5 benchmark iterations completes well within the remaining budget.

### 3.6 Validation: How I Know This Approach Will Work

I didn't design this configuration in a vacuum. I studied every comparable library integration on CE to validate my choices:

| Library | Build type | Link type | Dependencies | # Versions | What I learned |
|---------|-----------|-----------|-------------|-----------|---------------|
| **Kokkos** | cmake | static | none | 15 (4.0–5.0) | Parallel runtime, static linking, extensive `skip_compilers` — closest precedent to HPX |
| **Abseil** | cmake | static | none | 7 | Massive `staticliblink` lists (100+ libraries per version). HPX's 3-library setup is simple by comparison |
| **Boost (binary)** | cmake | shared | zlib | 10+ | Uses `%DEP0%` for zlib dependency — validates my `BOOST_ROOT=%DEP0%` approach |
| **fmt** | cmake | static | none | 30+ (4.0–12.0) | Simple, well-maintained — model for version management |
| **Catch2** | cmake | static | none | 10+ | Uses `make_targets: [Catch2, Catch2WithMain]` — shows targeted build approach |

HPX's complexity is most comparable to Kokkos: both are cmake-built parallel runtimes with per-compiler constraints and static linking. Kokkos has been successfully maintained on CE with 15 version targets over several years. If Kokkos works, HPX can work.

---

## 4. Implementation Plan

I'm organizing the work into four phases that build on each other. The first half is about getting the build right; the second half is about getting the user experience right.

### Phase 1: Local CE Setup and Dependency Resolution (Weeks 1–3)

**Week 1 — Getting my bearings.** I'll fork and clone both CE repositories, set up the local development environment (Node.js 20+, npm), and run CE locally at `localhost:10240`. The first milestone is simple: can I select an existing library (like fmt or Boost) on my local instance and compile a program? This validates my setup before I touch anything HPX-related.

I'll also read through the key source files I identified during research:
- `lib/options-handler.ts` — the `parseLibraries()` function that reads `.properties` files
- `lib/base-compiler.ts` — `findLibVersion()`, `getStaticLibraryLinks()`, `getSharedLibraryPaths()`
- `bin/lib/library_builder.py` — the `LibraryBuilder` class that orchestrates per-compiler builds
- `bin/lib/library_build_config.py` — `LibraryBuildConfig` that parses YAML entries

**Week 2 — Building HPX the CE way.** I'll build HPX locally using the `godbolt-minimal` preset, measuring build time and artifact size. Then I'll test with multiple compilers — GCC {10, 12, 14, 15} and Clang {15, 17, 18, 20} — to find which ones succeed and which ones fail. Each failure goes into the `skip_compilers` list.

I expect some edge cases: certain GCC 9.x builds might fail due to incomplete C++17 support, and very recent Clang versions sometimes introduce regressions with template-heavy code. I'll document every failure with the exact error message, because this data goes directly into the PR description.

**Week 3 — Solving the dependency puzzle.** This is the week I tackle hwloc. I'll engage the CE maintainers on their Discord to ask whether hwloc is pre-installed on build nodes. If not, I'll implement Strategy B (separate YAML entry) or validate Strategy C (fetch at build time).

I'll also validate the `BOOST_ROOT=%DEP0%` interpolation by building with it locally and checking that the HPX CMake configure picks up the correct Boost headers and libraries.

**Deliverable:** A working local HPX build with the exact YAML configuration that will be submitted upstream. I should be able to `ce_install cpp-library add` and have it parse correctly.

### Phase 2: Build Pipeline and Multi-Compiler Validation (Weeks 4–6)

**Week 4 — First successful build.** Write the complete `libraries.yaml` entry from Section 3.2. Run a test build for a single compiler (GCC 14, which is the most reliable for modern C++). Verify the artifact structure: headers should land in `include/`, static libraries in `lib/`.

**Week 5 — Scaling to all compilers.** Extend testing across every supported compiler. This is where I expect the most debugging work. HPX's template-heavy codebase sometimes triggers internal compiler errors (ICEs) on specific compiler versions. For each failure, I'll either add the compiler to `skip_compilers` or, if possible, adjust the CMake flags to work around the issue.

I'll also measure build times. If any compiler exceeds the 600-second default timeout in `library_builder.py`, I'll document it and request a timeout increase from CE maintainers (there's precedent: Qt and Boost both have custom timeouts).

**Week 6 — Conan packaging.** The final build pipeline step: verify that `conan export-pkg` correctly packages the HPX artifacts, and that a CE node can download and extract them. I'll test the complete flow: user selects HPX → correct include paths and linker flags are set → compilation succeeds → execution produces output.

**Midterm deliverable:** HPX compilation works on my local CE instance for at least one compiler with the complete build pipeline validated.

### Phase 3: Frontend Integration and User Experience (Weeks 7–9)

**Week 7 — Properties file and UI.** Write the `c++.amazon.properties` entries from Section 3.4. Verify that "HPX" appears in the library dropdown with the correct name, description, URL, and version list. Test that selecting HPX adds the right `-l` flags and include paths to the compile command.

**Week 8 — The default example.** Create the default example from Section 3.5. This needs to work on every supported compiler, produce meaningful output, and complete within the time budget. I'll also write a short CE-specific documentation section for the HPX repository — a README that explains how to use HPX on Compiler Explorer, what `sandbox.hpp` provides, and common gotchas.

**Week 9 — Edge cases and hardening.** This is the "what if the user does something unexpected?" week:
- What if they forget `hpx/hpx_main.hpp`? → The error message should be informative.
- What if they select an incompatible compiler? → HPX shouldn't appear for that compiler.
- What if their code takes too long? → Test with `--hpx:threads=1` and `--hpx:threads=2` to find the optimal default thread count for CE's 1–4 core environment.
- What does the CE "Execution" tab show? → It should show clean HPX output, not runtime initialization noise or thread pool diagnostics.

**Deliverable:** Complete frontend integration with a working default example, tested across all supported compilers.

### Phase 4: Upstream PRs and Handoff (Weeks 10–12)

**Week 10 — PR preparation.** I'll prepare three PRs with comprehensive descriptions, test results, and reviewer guidance:

| PR | Repository | Content | Depends on |
|----|-----------|---------|------------|
| #1 | `STEllAR-GROUP/hpx` | Updated `godbolt-minimal` preset for v2.0.0, `sandbox.hpp` refinements, CE integration docs | Nothing |
| #2 | `compiler-explorer/infra` | Updated `libraries.yaml` entry (+ hwloc entry if Strategy B) | PR #1 merged (so CE can fetch the correct HPX tag) |
| #3 | `compiler-explorer/compiler-explorer` | Properties file entries, default example code | PR #2 builds passing |

Each PR will include a test matrix showing which compilers pass, build times, and sample CE output.

**Week 11 — Review and iteration.** Submit all three PRs. I expect review feedback — CE maintainers are thorough, especially for complex compiled libraries. I'll respond promptly and iterate on the configuration based on their CI results.

**Week 12 — Final validation and documentation.** If CE has a staging environment, verify HPX works there. Write a blog post for the HPX community announcing the integration. Document the maintenance process so future HPX releases can be added without deep CE knowledge.

**Final deliverable:** All PRs submitted (ideally merged), HPX functional on Compiler Explorer, maintenance documentation complete.

---

## 5. Milestones and Schedule

**175-hour medium project**

| Week | Dates | Focus | Deliverable |
|------|-------|-------|-------------|
| CB | May 1–25 | Community Bonding: study CE codebases, join CE Discord, sync with mentors | Design document + build plan |
| 1 | May 26 – Jun 1 | Fork CE repos, local dev environment | Local CE instance running |
| 2 | Jun 2–8 | Build HPX with godbolt-minimal, multi-compiler testing | Compiler compatibility matrix |
| 3 | Jun 9–15 | Resolve hwloc/Boost/Asio dependencies | Working dependency chain |
| 4 | Jun 16–22 | Write libraries.yaml entry, initial build pipeline | YAML + single-compiler build |
| 5 | Jun 23–29 | Multi-compiler builds, fix per-compiler issues | All compilers building |
| **6** | **Jun 30** | **Midterm Evaluation** | **HPX compiling on local CE** |
| 7 | Jul 1–7 | Properties file, UI integration | HPX selectable in CE dropdown |
| 8 | Jul 8–14 | Default example, sandbox.hpp, documentation | Working example auto-loads |
| 9 | Jul 15–21 | Edge cases, execution limits, robustness | Full test matrix passing |
| 10 | Jul 22–28 | Prepare upstream PRs (all 3 repos) | PRs ready for submission |
| 11 | Jul 29 – Aug 4 | Submit PRs, respond to reviews | PRs under review |
| 12 | Aug 5–18 | Final validation, blog post, maintenance docs | All deliverables complete |
| — | Aug 19–25 | **Final Evaluation** | PRs merged, HPX live on CE |

### Gantt Chart

```
                  May        June               July               August
                  |CB  |W1  |W2  |W3  |W4  |W5  |W6  |W7  |W8  |W9  |W10 |W11 |W12 |
                  |    |    |    |    |    |    |    |    |    |    |    |    |    |
Community Bond.   |████|    |    |    |    |    |    |    |    |    |    |    |    |
Local Setup       |    |████|    |    |    |    |    |    |    |    |    |    |    |
HPX Build Test    |    |    |████|    |    |    |    |    |    |    |    |    |    |
Dep. Resolution   |    |    |    |████|    |    |    |    |    |    |    |    |    |
YAML + Pipeline   |    |    |    |    |████|████|    |    |    |    |    |    |    |
                  ─────────────────────────── MIDTERM ─────────────────────────────
Props + UI        |    |    |    |    |    |    |    |████|    |    |    |    |    |
Example + Docs    |    |    |    |    |    |    |    |    |████|    |    |    |    |
Edge Cases        |    |    |    |    |    |    |    |    |    |████|    |    |    |
Upstream PRs      |    |    |    |    |    |    |    |    |    |    |████|████|    |
Final + Blog      |    |    |    |    |    |    |    |    |    |    |    |    |████|
                  ──────────────────────────────────────────────────── FINAL ─────
```

---

## 6. Risk Analysis and Mitigation

| Risk | How likely? | What I'll do |
|------|-----------|-------------|
| **Build timeout** — HPX exceeds CE's 600s per-compiler build limit | Medium | Ninja cuts build time ~50%. `DISTRIBUTED_RUNTIME=OFF` eliminates ~30% of sources. If still not enough, I'll request a custom timeout (precedent: Qt, Boost). |
| **hwloc unavailable** on CE build nodes and fetch fails | Low–Medium | Fall back to `HPX_WITH_HWLOC=OFF`. HPX uses `std::thread::hardware_concurrency()` instead — perfectly fine for a 1–4 core sandbox. |
| **Runtime initialization overhead** eats into CE's 10s execution budget | Low | HPX init takes 50–200ms. Within budget. If problematic, configure `--hpx:threads=1` to minimize startup cost. |
| **CE maintainer review** takes longer than expected for complex PRs | Medium | I'll engage the CE community early (Discord, during bonding). Model my PRs on successful complex-library additions (Kokkos, Qt). Open draft PRs in Week 5 for early feedback. |
| **Compiler ICEs** on specific versions I didn't test locally | Medium | Comprehensive `skip_compilers` list. CE's build pipeline logs every failure — I can iterate on the exclusion list remotely. |
| **HPX release during GSoC** changes the build | Low | The `godbolt-minimal` preset is part of HPX's release process. I'll track the HPX release branch and adjust if needed. |

---

## 7. Stretch Goals

These are things I'd like to do if the core integration lands ahead of schedule:

- **Nightly builds.** Add an HPX nightly entry that tracks the `master` branch, so CE users can test bleeding-edge features. This follows the pattern used by 50+ other CE libraries.
- **Example gallery.** A curated set of HPX examples beyond the default: futures and continuations, task-based parallelism, parallel sort, async I/O patterns. Each one demonstrates a different HPX capability.
- **CMake editor mode.** CE supports multi-file CMake projects. I'd contribute toolchain files and `CMakeLists.txt` templates for HPX projects in this mode.
- **Custom CE instance.** If CE's execution time limit proves too constraining for meaningful HPX demos, deploy a custom CE instance on HPX project infrastructure with relaxed limits and pre-loaded examples. Projects like Seastar and MLIR have done this successfully.

---

## 8. Why This Matters

I want to close with something beyond the technical details.

HPX has been in development for over a decade. It's one of the most ambitious C++ projects in the HPC ecosystem — a full implementation of the parallel algorithms standard, extended with task-based parallelism, futures, dataflow, and distributed computing. The STE||AR Group has put thousands of hours into making it work.

And yet, if a curious developer at a conference hears "HPX" for the first time and wants to try it — the answer today is "go home, install five dependencies, build for 30 minutes, and then you can run your first parallel for_each." Compare that to Kokkos: "open godbolt.org, check the Kokkos box, type your code, click Run."

Presence on Compiler Explorer isn't just a convenience — it's how libraries get adopted in the modern C++ world. It's how students discover tools. It's how conference speakers share live demos. It's how the Standards Committee evaluates implementations.

This project makes HPX visible to the 3.5 million developers who use Compiler Explorer every month. That's worth doing.
