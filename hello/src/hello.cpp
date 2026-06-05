#include "hello/hello.hpp"

namespace hello {

std::string message(const std::string& name)
{
    return "Hello, " + name + "!";
}

}  // namespace hello
