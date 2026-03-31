// HPX: The C++ Standard Library for Parallelism and Concurrency
// Try changing 'par' to 'seq' to compare performance!

#include <hpx/hpx_main.hpp>
#include <hpx/algorithm.hpp>
#include <hpx/numeric.hpp>
#include <hpx/experimental/sandbox.hpp>
#include <iostream>
#include <numeric>
#include <vector>

int main()
{
    hpx::experimental::sandbox::describe_environment(std::cout);

    constexpr std::size_t N = 1'000'000;
    std::vector<double> data(N);
    std::iota(data.begin(), data.end(), 1.0);

    auto report = hpx::experimental::sandbox::benchmark(
        "transform_reduce (1M doubles)",
        [&]() {
            volatile double r = hpx::transform_reduce(
                hpx::execution::seq, data.begin(), data.end(),
                0.0, std::plus<>{}, [](double x) { return x * x; });
            (void)r;
        },
        [&]() {
            volatile double r = hpx::transform_reduce(
                hpx::execution::par, data.begin(), data.end(),
                0.0, std::plus<>{}, [](double x) { return x * x; });
            (void)r;
        }
    );
    report.print(std::cout);
}
