// =============================================================================
// transform_reduce.cpp
// HPX parallel transform_reduce example for Compiler Explorer
//
// Compile flags:  -std=c++20 -DHPX_APPLICATION_EXPORTS
// Libraries:      HPX 2.0.0
// Expected output: Sum of squares: 204
//
// Algorithm: sum of x^2 for x in {1,2,3,4,5,6,7,8}
//   = 1 + 4 + 9 + 16 + 25 + 36 + 49 + 64 = 204
// =============================================================================
#include <hpx/hpx_main.hpp>
#include <hpx/numeric.hpp>
#include <hpx/algorithm.hpp>
#include <vector>
#include <iostream>

int main() {
    std::vector<int> v = {1, 2, 3, 4, 5, 6, 7, 8};

    // Parallel transform_reduce: sum of squares using HPX parallel execution
    auto result = hpx::transform_reduce(
        hpx::execution::par,      // parallel execution policy
        v.begin(), v.end(),
        0,                        // initial value
        std::plus<>{},            // reduce operation: addition
        [](int x) { return x * x; }  // transform: square each element
    );

    std::cout << "Sum of squares: " << result << std::endl;
    return 0;
}
