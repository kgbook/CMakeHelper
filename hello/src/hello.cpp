#include "hello/hello.hpp"

namespace hello {

std::string message(std::string_view name)
{
    return "Hello, " + std::string(name) + "!";
}

}  // namespace hello
