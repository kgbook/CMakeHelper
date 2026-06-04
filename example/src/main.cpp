#include "hello/hello.hpp"

#include <iostream>
#include <string_view>

namespace {

constexpr std::string_view default_name()
{
    if constexpr (sizeof(void*) >= 8) {
        return "world";
    } else {
        return "embedded world";
    }
}

}  // namespace

int main()
{
    std::cout << hello::message(default_name()) << '\n';
    return 0;
}
