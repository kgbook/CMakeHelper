#include "hello/hello.hpp"

#include <iostream>
#include <string>

namespace {

std::string default_name()
{
    return "world";
}

}  // namespace

int main()
{
    std::cout << hello::message(default_name()) << '\n';
    return 0;
}
