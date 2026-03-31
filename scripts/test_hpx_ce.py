#!/usr/bin/env python3
"""
test_hpx_ce.py — Verify HPX compiles and runs inside Compiler Explorer via API.

Usage:
    python3 scripts/test_hpx_ce.py [ce_url]

Default CE URL: http://localhost:10240

Expected output:
    Compile: PASS (exit 0)
    Execute: PASS (exit 0)
    Output:  Sum of squares: 204
"""

import json
import sys
import urllib.request

CE_URL = sys.argv[1] if len(sys.argv) > 1 else "http://localhost:10240"

SOURCE = r"""#include <hpx/hpx_main.hpp>
#include <hpx/numeric.hpp>
#include <hpx/algorithm.hpp>
#include <vector>
#include <iostream>

int main() {
    std::vector<int> v = {1, 2, 3, 4, 5, 6, 7, 8};

    // Parallel transform_reduce: sum of squares
    auto result = hpx::transform_reduce(
        hpx::execution::par,
        v.begin(), v.end(),
        0,
        std::plus<>{},
        [](int x) { return x * x; });

    std::cout << "Sum of squares: " << result << std::endl;
    return 0;
}
"""

PAYLOAD = {
    "source": SOURCE,
    "compiler": "clanglocal",
    "options": {
        "userArguments": "-std=c++20 -DHPX_APPLICATION_EXPORTS",
        "compilerOptions": {},
        "filters": {"execute": True},
        "libraries": [{"id": "hpx", "version": "200"}],
    },
    "lang": "c++",
    "allowStoreCodeDebug": True,
}


def check(ce_url: str) -> bool:
    # 1. Check HPX is registered
    req = urllib.request.Request(
        f"{ce_url}/api/libraries/c++",
        headers={"Accept": "application/json"},
    )
    with urllib.request.urlopen(req, timeout=10) as r:
        libs = json.loads(r.read())
    hpx = [l for l in libs if l.get("id") == "hpx"]
    if not hpx:
        print("FAIL: HPX not found in CE library list")
        return False
    print(f"Library: PASS  (HPX {hpx[0]['versions'][0]['version']} registered)")

    # 2. Compile + execute
    data = json.dumps(PAYLOAD).encode()
    req = urllib.request.Request(
        f"{ce_url}/api/compiler/clanglocal/compile",
        data=data,
        headers={"Content-Type": "application/json", "Accept": "application/json"},
    )
    with urllib.request.urlopen(req, timeout=120) as r:
        result = json.loads(r.read())

    compile_ok = result.get("code", 1) == 0
    print(f"Compile: {'PASS' if compile_ok else 'FAIL'}  (exit {result.get('code')})")
    if not compile_ok:
        for line in result.get("stderr", [])[:10]:
            print(f"  {line.get('text', '')}")
        return False

    exec_result = result.get("execResult", {})
    exec_code = exec_result.get("code", -1)
    exec_ok = exec_code == 0
    print(f"Execute: {'PASS' if exec_ok else 'FAIL'}  (exit {exec_code})")

    output_lines = [l.get("text", "") for l in exec_result.get("stdout", [])]
    if output_lines:
        print(f"Output:  {output_lines[0]}")

    if exec_result.get("stderr"):
        for line in exec_result["stderr"][:3]:
            print(f"  stderr: {line.get('text', '')}")

    return compile_ok and exec_ok


if __name__ == "__main__":
    print(f"Testing HPX in Compiler Explorer at {CE_URL}\n")
    success = check(CE_URL)
    print(f"\n{'All checks PASSED ✓' if success else 'Some checks FAILED ✗'}")
    sys.exit(0 if success else 1)
