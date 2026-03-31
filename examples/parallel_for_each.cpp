// =============================================================================
// parallel_for_each.cpp
// HPX parallel for_each example for Compiler Explorer
//
// Compile flags:  -std=c++20 -DHPX_APPLICATION_EXPORTS
// Libraries:      HPX 2.0.0
// =============================================================================
#include <hpx/hpx_main.hpp>
#include <hpx/algorithm.hpp>
#include <vector>
#include <iostream>
#include <mutex>

int main() {
    std::vector<int> v = {1, 2, 3, 4, 5};
    std::mutex m;
    std::vector<int> results;

    hpx::for_each(
        hpx::execution::par,
        v.begin(), v.end(),
        [&](int x) {
            std::lock_guard<std::mutex> lock(m);
            results.push_back(x * x);
        });

    // Sort so output is deterministic
    std::sort(results.begin(), results.end());
    for (int r : results)
        std::cout << r << " ";
    std::cout << std::endl;
    return 0;
}
