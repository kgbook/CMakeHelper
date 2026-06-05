#include "auto_lists/direct.hpp"
#include "auto_lists/phrase.hpp"

#include <iostream>

int main()
{
    std::cout << auto_lists::direct_message() << " + " << auto_lists::phrase() << '\n';
    return 0;
}
